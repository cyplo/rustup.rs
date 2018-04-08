#!/bin/sh

set -ex

echo "toolchain versions\n------------------"

rustc -vV
cargo -vV

if [ ! -z "$CHECK_RUSTFMT" ]; then
    cargo fmt --all -- --write-mode=diff
fi

cargo build --locked -v --release --target $TARGET

if [ -z "$SKIP_TESTS" ]; then
  cargo test --release -p download --target $TARGET
  cargo test --release -p rustup-dist --target $TARGET
  cargo test --release --target $TARGET
fi
