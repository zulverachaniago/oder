#!/usr/bin/env bash
# Install Ruby 3.4.1 dengan rbenv di macOS Apple Silicon (arm64)
# Fix untuk error: OpenSSL library could not be found

set -e

# Path Homebrew untuk Apple Silicon
HOMEBREW_PREFIX="/opt/homebrew"

export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$HOMEBREW_PREFIX/opt/openssl@3 --with-libyaml-dir=$HOMEBREW_PREFIX/opt/libyaml"
export LDFLAGS="-L$HOMEBREW_PREFIX/opt/openssl@3/lib -L$HOMEBREW_PREFIX/opt/libyaml/lib"
export CPPFLAGS="-I$HOMEBREW_PREFIX/opt/openssl@3/include -I$HOMEBREW_PREFIX/opt/libyaml/include"
export PKG_CONFIG_PATH="$HOMEBREW_PREFIX/opt/openssl@3/lib/pkgconfig:$HOMEBREW_PREFIX/opt/libyaml/lib/pkgconfig"

echo "Installing Ruby 3.4.1 with OpenSSL and libyaml from $HOMEBREW_PREFIX..."
rbenv install 3.4.1

echo "Done. Set local version with: rbenv local 3.4.1"
