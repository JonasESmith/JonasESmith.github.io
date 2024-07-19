use std::{fs, path::Path, process::Command};

use portfolio_data::models::AppData;
use quick_type_schema::{CodegenContext, Language};
fn main() {
    // quicktype cli override arguments can be explicitly added here.
    // These overrides even affect `Language` passed in `codegen.finish`
    // Ex: `Some(&["-l", "typescript", "--just-types"])`
    let mut codegen = CodegenContext::new(Some(&["-l", "dart", "--use-freezed"]));

    // Add a type that has derived `JsonSchema`
    codegen.add_type::<AppData>();

    let output = codegen.finish(Language::Dart { use_freezed: true });

    // Remove the first 22 lines from the generated code
    let lines: Vec<&str> = output.split('\n').collect();
    let modified_lines = lines[22..].join("\n");

    // Add the desired lines at the beginning of the code
    let final_output = format!(
        "import 'package:freezed_annotation/freezed_annotation.dart';\n\npart 'app_data.freezed.dart';\npart 'app_data.g.dart';\n\n{}",
        modified_lines
    );

    // Get the path to the app_data.dart file relative to the current directory
    let app_data_path = Path::new("../lib/src/model/app_data.dart");

    // Write the modified code to the app_data.dart file
    match fs::write(app_data_path, final_output) {
        Ok(_) => println!("Generated code saved to app_data.dart"),
        Err(e) => eprintln!("Error saving generated code: {}", e),
    }

    // Change the current directory to the Flutter project directory
    let flutter_project_dir = Path::new("../");
    match std::env::set_current_dir(flutter_project_dir) {
        Ok(_) => println!("Changed directory to Flutter project"),
        Err(e) => eprintln!("Error changing directory: {}", e),
    }

    // Run the command "dart run build_runner build --delete-conflicting-outputs"
    let output = Command::new("dart")
        .arg("run")
        .arg("build_runner")
        .arg("build")
        .arg("--delete-conflicting-outputs")
        .output()
        .expect("Failed to execute command");

    println!(
        "Command output: {}",
        String::from_utf8_lossy(&output.stdout)
    );
}
