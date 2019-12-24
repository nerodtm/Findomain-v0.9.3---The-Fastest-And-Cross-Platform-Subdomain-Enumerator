# Findomain releaser
WIN_TARGET="x86_64-pc-windows-gnu"
AARCH_TARGET="aarch64-unknown-linux-gnu"
OSX_TARGET="x86_64-apple-darwin"
MANPAGE_DIR="./findomain.1"

# Linux build
echo "Building Linux artifact."
if cargo build -q --release; then
  echo "Linux artifact build: SUCCESS"
  cp "target/release/findomain" "target/release/findomain-linux"
else
  echo "Linux artifact build: FAILED"
fi

# Windows build
echo "Building Windows artifact."
if cargo build -q --release --target="$WIN_TARGET"; then
  echo "Windows artifact build: SUCCESS"
  cp "target/$WIN_TARGET/release/findomain.exe" "target/$WIN_TARGET/release/findomain-windows.exe"
else
  echo "Windows artifact build: FAILED"
fi

# Aarch64 build
echo "Building Aarch64 artifact."
if cargo build -q --release --target="$AARCH_TARGET"; then
  echo "Aarch64 artifact build: SUCCESS"
  cp "target/$AARCH_TARGET/release/findomain" "target/$AARCH_TARGET/release/findomain-aarch64"
else
  echo "Aarch64 artifact build: FAILED"
fi

# Mac OS build
echo "Building OSX artifact."
if CC=o64-clang CXX=o64-clang++ LIBZ_SYS_STATIC=1 cargo build -q --release --target="$OSX_TARGET"; then
  echo "OSX artifact build: SUCCESS"
  cp "target/$OSX_TARGET/release/findomain" "target/$OSX_TARGET/release/findomain-osx"
else
  echo "OSX artifact build: FAILED"
fi

echo "Creating manpage..."
if command -v help2man > /dev/null; then
  if help2man -o "$MANPAGE_DIR" "target/release/findomain"; then
    echo "Manpage created sucessfully and saved in $MANPAGE_DIR"
  else
    echo "Error creating manpage."
  fi
else
  echo "Please install the help2man package."
fi

