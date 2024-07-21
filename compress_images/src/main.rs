use image::{GenericImageView, ImageFormat};
use std::fs;
use std::path::{Path, PathBuf};
use walkdir::WalkDir;

#[derive(Debug, Clone)]
struct Args {
    input_dir: String,
    output_dir: String,
    ratio: f32,
    output_format: ImageFormat,
}

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let ratio: f32 = 0.279;

    let directories = vec![
        ("../images/rcg".to_string(), ImageFormat::Jpeg, ratio),
        ("../images/bfs".to_string(), ImageFormat::Jpeg, ratio),
        ("../images/pakmo".to_string(), ImageFormat::Jpeg, ratio),
        ("../images/eqalink".to_string(), ImageFormat::Jpeg, ratio),
    ];

    let mut total_original_size = 0;
    let mut total_compressed_size = 0;

    for (directory, format, ratio) in directories {
        if let Err(e) = process_images(
            directory,
            format,
            ratio,
            &mut total_original_size,
            &mut total_compressed_size,
        ) {
            eprintln!("Error processing directory: {}", e);
        }
    }

    let total_saved = total_original_size - total_compressed_size;
    let compression_ratio = 1.0 - (total_compressed_size as f64 / total_original_size as f64);

    println!("\n{:-<66}", "");
    println!(
        "Total space saved: {:.2} MB ({:.1}% reduction)",
        total_saved as f64 / (1024.0 * 1024.0),
        compression_ratio * 100.0
    );
    println!(
        "Original size: {:.2} MB, Compressed size: {:.2} MB",
        total_original_size as f64 / (1024.0 * 1024.0),
        total_compressed_size as f64 / (1024.0 * 1024.0)
    );

    Ok(())
}
fn process_images(
    directory: String,
    format: ImageFormat,
    ratio: f32,
    total_original_size: &mut u64,
    total_compressed_size: &mut u64,
) -> Result<(), Box<dyn std::error::Error>> {
    println!(
        "Processing directory: {} with format: {:?}, ratio: {:.3}",
        directory, format, ratio
    );

    let args = Args {
        output_dir: "../images/compressed".to_string(),
        input_dir: directory,
        ratio,
        output_format: format,
    };

    println!(
        "\n{:<30} {:>12} {:>12} {:>10}",
        "File", "Original", "Compressed", "Reduction"
    );
    println!("{:-<30} {:->12} {:->12} {:->10}", "", "", "", "");

    for entry in WalkDir::new(&args.input_dir) {
        let entry = entry?;
        if entry.file_type().is_file() {
            let path = entry.path();
            if should_process_image(path) {
                let original_size = fs::metadata(path)?.len();
                match process_image(path, &args) {
                    Ok(new_path) => {
                        let new_size = fs::metadata(&new_path)?.len();
                        let compression_ratio = 1.0 - (new_size as f64 / original_size as f64);
                        println!(
                            "{:<30} {:>12.2} {:>12.2} {:>9.1}%",
                            path.file_name().unwrap().to_string_lossy(),
                            original_size as f64 / 1024.0,
                            new_size as f64 / 1024.0,
                            compression_ratio * 100.0
                        );
                        *total_original_size += original_size;
                        *total_compressed_size += new_size;
                    }
                    Err(e) => eprintln!("Error processing {}: {}", path.display(), e),
                }
            }
        }
    }

    Ok(())
}

fn should_process_image(path: &Path) -> bool {
    let is_image = matches!(
        path.extension().and_then(|s| s.to_str()),
        Some("jpg" | "jpeg" | "png")
    );
    let is_not_in_compressed = !path.to_string_lossy().contains("/compressed/");
    is_image && is_not_in_compressed
}

fn process_image(input_path: &Path, args: &Args) -> Result<PathBuf, Box<dyn std::error::Error>> {
    let output_path = get_output_path(input_path, &args.output_dir, args.output_format)?;

    let img = image::open(input_path).map_err(|e| {
        std::io::Error::new(
            std::io::ErrorKind::Other,
            format!(
                "Failed to open image: {}. Error: {}",
                input_path.display(),
                e
            ),
        )
    })?;

    let (width, height) = img.dimensions();

    let new_width = (width as f32 * args.ratio) as u32;
    let new_height = (height as f32 * args.ratio) as u32;
    let img = img.resize(new_width, new_height, image::imageops::FilterType::Lanczos3);

    fs::create_dir_all(output_path.parent().unwrap())?;

    match args.output_format {
        ImageFormat::Png => img.save_with_format(&output_path, ImageFormat::Png)?,
        _ => {
            let rgb_img = img.into_rgb8();
            rgb_img.save_with_format(&output_path, args.output_format)?
        }
    }

    Ok(output_path)
}

fn get_output_path(
    input_path: &Path,
    output_dir: &str,
    format: ImageFormat,
) -> Result<PathBuf, Box<dyn std::error::Error>> {
    let relative_path = input_path.strip_prefix("../images")?;
    let mut output_path = PathBuf::from(output_dir);
    output_path.push(relative_path);

    let extension = match format {
        ImageFormat::Png => "png",
        ImageFormat::Jpeg => "jpeg",
        ImageFormat::Gif => "gif",
        ImageFormat::WebP => "webp",
        _ => "jpeg", // Default to jpeg for other formats
    };
    output_path.set_extension(extension);

    Ok(output_path)
}
