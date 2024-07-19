# Portfolio

A basic portfolio site, using flutter and rust. Wanted this to feel take some inspiration from basic IDE's and add some nice custom theming, so built out the application to have many different themes the user can select from.

## Technologies Used

- [Flutter](https://flutter.dev/): Mature front end framework
- [Rust](https://www.rust-lang.org/): Type safe, and powerful
- [Quicktype](https://quicktype.io/): Allows for conversion of rust -> dart

## Getting started

Clone repo

```bash
git clone https://github.com/JonasESmith/JonasESmith.github.io.git
```

get necessary packages

```bash
cd JonasESmith.github.io && flutter pub get
```

build for...

```bash
flutter run -d chrome
flutter run -d macos
flutter run ... other devices

```

> making changes to app_data.rs inside of `portfolio_data/`

```bash
cd portfolio_data
cargo run
```
