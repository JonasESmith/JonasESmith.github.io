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

# Add the redirection script to index.html
sed -i '' '/<body>/r'<(cat << EOF

<script>
  (function() {
    var redirect = sessionStorage.redirect;
    delete sessionStorage.redirect;
    if (redirect && redirect != location.href) {
      history.replaceState(null, null, redirect);
    }
  })();
</script>
EOF
) build/web/index.html

# Create 404.html file
cat > build/web/404.html << EOF
<!DOCTYPE html>
<html>
<head>
  <script>
    sessionStorage.redirect = location.href;
  </script>
  <meta http-equiv="refresh" content="0;URL='/'">
</head>
<body>
</body>
</html>
EOF

# Navigate to the build/web directory
cd build/web

# Create the assets directory in the root if it doesn't exist
mkdir -p ../../assets

# Copy all files and folders except assets/ to the root directory
find . -maxdepth 1 ! -name 'assets' ! -name '.' -exec cp -R {} ../../ \;

# Copy assets/ into the assets/ folder at root
cp -R assets/* ../../assets/

# Navigate back to the root directory
cd ../..

# Move assets/projects/assets into assets/
if [ -d "assets/projects/assets" ]; then
  mv assets/projects/assets/* assets/
  rm -rf assets/projects/assets
  echo "Moved assets/projects/assets into assets/"
else
  echo "Warning: assets/projects/assets directory not found"
fi

echo "Build complete. Files have been copied to the root directory and assets restructured."