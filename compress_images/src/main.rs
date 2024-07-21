use image::{GenericImageView, ImageFormat};
use std::fs;
use std::path::{Path, PathBuf};
use walkdir::WalkDir;

#[derive(Debug, Clone)]
struct Args {
    input_dir: String,
    output_dir: String,
    max_width: u32,
}

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let args = Args {
        output_dir: "../images/compressed".to_string(),
        input_dir: "../images/bfs".to_string(),
        max_width: 400,
    };

    // realistcally we could change this up,,,
    let _ = process_images(args.input_dir);

    Ok(())
}

/// we can take a direcory here like "../images/rcg", and we will now
/// only look at this specific folder.
fn process_images(directory: String) -> Result<(), Box<dyn std::error::Error>> {
    let args = Args {
        output_dir: "../images/compressed".to_string(),
        input_dir: format!("../{}", directory).to_string(),
        max_width: 400,
    };

    for entry in WalkDir::new(&args.input_dir) {
        let entry = entry?;
        if entry.file_type().is_file() {
            let path = entry.path();
            if should_process_image(path) {
                match process_image(path, &args) {
                    Ok(_) => println!("Successfully processed: {}", path.display()),
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

fn process_image(input_path: &Path, args: &Args) -> Result<(), Box<dyn std::error::Error>> {
    let is_icon = input_path.components().any(|c| c.as_os_str() == "icons");
    let output_path = get_output_path(input_path, &args.output_dir)?;

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

    let img = if width > args.max_width {
        let ratio = args.max_width as f32 / width as f32;
        let new_height = (height as f32 * ratio) as u32;
        img.resize(
            args.max_width,
            new_height,
            image::imageops::FilterType::Lanczos3,
        )
    } else {
        img
    };

    fs::create_dir_all(output_path.parent().unwrap())?;

    if is_icon && input_path.extension().map_or(false, |ext| ext == "png") {
        img.save_with_format(&output_path, ImageFormat::Png)?;
    } else {
        let rgb_img = img.into_rgb8();
        rgb_img.save_with_format(&output_path, ImageFormat::Jpeg)?;
    }

    Ok(())
}

fn get_output_path(
    input_path: &Path,
    output_dir: &str,
) -> Result<PathBuf, Box<dyn std::error::Error>> {
    let relative_path = input_path.strip_prefix("../images")?;
    let mut output_path = PathBuf::from(output_dir);
    output_path.push(relative_path);

    if output_path.extension().map_or(false, |ext| ext != "png") {
        output_path.set_extension("jpeg");
    }

    Ok(output_path)
}
