use image::{GenericImageView, ImageFormat};
use std::fs;
use std::path::Path;
use walkdir::WalkDir;

struct Args {
    input_dir: String,

    output_dir: String,

    quality: u8,

    max_width: u32,
}

pub fn image_compress() -> Result<(), Box<dyn std::error::Error>> {
    let args = Args {
        quality: 15,
        max_width: 1024,
        input_dir: "../images".to_string(),
        output_dir: "../images/compressed".to_string(),
    };

    for entry in WalkDir::new(&args.input_dir) {
        let entry = entry?;
        if entry.file_type().is_file() {
            if let Some(extension) = entry.path().extension() {
                if extension == "jpg" || extension == "jpeg" || extension == "png" {
                    compress_image(entry.path(), &args.output_dir, args.quality, args.max_width)?;
                }
            }
        }
    }

    Ok(())
}

fn compress_image(
    input_path: &Path,
    output_dir: &str,
    quality: u8,
    max_width: u32,
) -> Result<(), Box<dyn std::error::Error>> {
    let img = image::open(input_path)?;
    let (width, height) = img.dimensions();

    let img = if width > max_width {
        let ratio = max_width as f32 / width as f32;
        let new_height = (height as f32 * ratio) as u32;
        img.resize(max_width, new_height, image::imageops::FilterType::Lanczos3)
    } else {
        img
    };

    let output_path = Path::new(output_dir).join(input_path.file_name().unwrap());
    fs::create_dir_all(output_path.parent().unwrap())?;

    img.save_with_format(&output_path, ImageFormat::Jpeg)?;

    Ok(())
}
