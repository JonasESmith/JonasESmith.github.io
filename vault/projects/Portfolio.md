---
title: "Portfolio"
description: "A looking glass into my projects, work, and love for building"
order: 4
draft: false
icon: "dagger.png"
start: "2023-06-01"
platforms:
  - "ios"
  - "android"
  - "web"
  - "macos"
technologies:
  - name: "Flutter"
    url: "https://flutter.dev/"
  - name: "React"
  - name: "Rust"
    url: "https://www.rust-lang.org/"
  - name: "Bloc"
    url: "https://pub.dev/packages/bloc"
  - name: "Firebase"
    url: "https://firebase.google.com/"
  - name: "Freezed"
    url: "https://pub.dev/packages/freezed"
  - name: "FlutterModular"
    url: "https://pub.dev/packages/flutter_modular"
---

I wanted to create a simple, yet beautiful adaptive site to show the many things I like to work on.

> Why use Rust?

Rust is a complete game changer for productivity and error-free code. Using [flutter_rust_bridge](https://cjycode.com/flutter_rust_bridge/) and custom bash scripts I can make generating models much faster.

```rust
#[derive(Deserialize, Serialize, JsonSchema)]
pub struct AppData {
    pub nav_width: i32,
    pub profile: Profile,
    pub skills: Vec<Skill>,
    pub projects: Vec<Project>,
    pub work: Vec<WorkExperience>,
}
```

```rust
fn main() {
    let mut codegen = CodegenContext::new(Some(&["-l", "dart", "--use-freezed"]));
    codegen.add_type::<AppData>();
    let output = codegen.finish(Language::Dart);
}
```

```bash
#!/bin/bash
cd portfolio_data
cd ..
echo "Build completed successfully!"
```
