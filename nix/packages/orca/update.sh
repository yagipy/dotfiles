#!/bin/sh
# GitHub Releasesの最新版に合わせてsource.jsonを更新する
set -eu

cd "$(dirname "$0")"

version="$(gh release view --repo stablyai/orca --json tagName --jq '.tagName | ltrimstr("v")')"
url="https://github.com/stablyai/orca/releases/download/v$version/Orca-$version-arm64-mac.zip"
hash="$(nix store prefetch-file --json --hash-type sha256 "$url" | jq -r .hash)"

jq -n --arg version "$version" --arg url "$url" --arg hash "$hash" \
  '{ version: $version, url: $url, hash: $hash }' >source.json
