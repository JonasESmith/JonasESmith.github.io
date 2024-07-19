#!/bin/bash

# Define the loading animation function
loading_animation() {
  local delay=0.1
  local spinstr='|/-\'
  while [ "$1" != "done" ]; do
    local temp=${spinstr#?}
    printf " [%c]  " "$spinstr"
    local spinstr=$temp${spinstr%"$temp"}
    sleep $delay
    printf "\b\b\b\b\b\b"
  done
  printf "    \b\b\b\b"
}

# Navigate to the portfolio_data directory
cd portfolio_data

# Run cargo run with loading indicator
echo "Converting Rust -> Dart..."
loading_animation & cargo run ; kill $! 2>/dev/null

# Navigate back to the Flutter project root
cd ..

# Run build_runner with loading indicator
echo "Running build_runner..."
loading_animation & dart run build_runner build --delete-conflicting-outputs ; kill $! 2>/dev/null

echo "Build completed successfully!"

# Build the Flutter web application
flutter build web --release 

# Remove the <base href="/"> line from index.html
sed -i '' '/<base href="\/"/d' build/web/index.html

# Navigate to the build/web directory
cd build/web

# Create the projects/assets directory in the root
mkdir -p ../../projects/assets

# Copy all files and folders except assets/ to the root directory
find . -maxdepth 1 ! -name 'assets' ! -name '.' -exec cp -R {} ../../ \;

# Copy assets/ into the projects/assets/ folder at root
cp -R assets ../../projects/

# Navigate back to the root directory
cd ../..

echo "Build complete. Files have been copied to the root directory and assets to projects/assets/."