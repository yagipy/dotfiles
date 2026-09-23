#!/bin/sh
# curl -fsSL https://raw.githubusercontent.com/yagipy/dotfiles/master/install.sh | sh
set -eu

DOTFILES_DIR="$HOME/dotfiles"
NIX_DAEMON_PROFILE="/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"

if [ ! -e "$NIX_DAEMON_PROFILE" ]; then
  echo "=> Nixをインストール"
  curl -sSfL https://artifacts.nixos.org/nix-installer | sh -s -- install --enable-flakes
fi
# shellcheck disable=SC1090
. "$NIX_DAEMON_PROFILE"

for pkg in git gh; do
  PATH="$(nix build --no-link --print-out-paths "nixpkgs#$pkg")/bin:$PATH"
done
export PATH

if ! gh auth status >/dev/null 2>&1; then
  echo "=> GitHubにログイン"
  gh auth login </dev/tty
fi

export GIT_CONFIG_COUNT=2
export GIT_CONFIG_KEY_0="credential.https://github.com.helper"
export GIT_CONFIG_VALUE_0=""
export GIT_CONFIG_KEY_1="credential.https://github.com.helper"
export GIT_CONFIG_VALUE_1="!gh auth git-credential"

if [ ! -d "$DOTFILES_DIR" ]; then
  echo "=> dotfilesをクローン"
  git clone https://github.com/yagipy/dotfiles "$DOTFILES_DIR"
fi
cd "$DOTFILES_DIR"

echo "=> nix-darwinの設定をビルド"
system="$(nix build --no-link --print-out-paths ".#darwinConfigurations.$USER.system")"

# Nixのインストーラーが書き換えたファイルはnix-darwinが上書きを拒否するため退避
for file in /etc/bashrc /etc/zshrc /etc/zshenv /etc/nix/nix.conf; do
  if [ -f "$file" ] && [ ! -L "$file" ]; then
    echo "=> $file を $file.before-nix-darwinに退避"
    sudo mv "$file" "$file.before-nix-darwin"
  fi
done

echo "=> nix-darwinの設定を適用"
sudo nix-env -p /nix/var/nix/profiles/system --set "$system"
sudo "$system/activate"
