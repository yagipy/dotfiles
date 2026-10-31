{ pkgs, ... }:
let
  warpInstaller = pkgs.runCommand "cloudflare-warp-installer-${pkgs.cloudflare-warp.version}" { } ''
    mkdir -p "$out"
    cp ${pkgs.cloudflare-warp.src} "$out/Cloudflare_WARP.pkg"
  '';
  karabinerInstaller = pkgs.runCommand "karabiner-elements-installer-${pkgs.karabiner-elements.version}"
    { nativeBuildInputs = [ pkgs.undmg ]; }
    ''
      undmg ${pkgs.karabiner-elements.src}
      mkdir -p "$out"
      cp Karabiner-Elements.pkg "$out/"
    '';
in
{
  system.activationScripts.postActivation.text = ''
    (
      set -e
      marker=/var/lib/nix-cloudflare-warp/installer
      if [ ! -f "$marker" ] || \
         [ "$(cat "$marker")" != "${warpInstaller}" ] || \
         [ ! -d "/Applications/Cloudflare WARP.app" ]; then
        /usr/sbin/installer -pkg "${warpInstaller}/Cloudflare_WARP.pkg" -target /
        mkdir -p /var/lib/nix-cloudflare-warp
        printf '%s\n' '${warpInstaller}' > "$marker"
      fi
    )
    (
      set -e
      marker=/var/lib/nix-karabiner-elements/installer
      if [ ! -f "$marker" ] || \
         [ "$(cat "$marker")" != "${karabinerInstaller}" ] || \
         [ ! -d /Applications/Karabiner-Elements.app ]; then
        /usr/sbin/installer -pkg "${karabinerInstaller}/Karabiner-Elements.pkg" -target /
        mkdir -p /var/lib/nix-karabiner-elements
        printf '%s\n' '${karabinerInstaller}' > "$marker"
      fi
    )
  '';

  environment.systemPackages = [
    (pkgs.callPackage ../packages/clipy.nix { })
    (pkgs.callPackage ../packages/dia.nix { })
    (pkgs.callPackage ../packages/orca.nix { })
    pkgs.ghostty-bin
    pkgs.google-chrome
    pkgs.notion-app
    pkgs.raycast
    pkgs.slack
    pkgs.vscode
  ];
}
