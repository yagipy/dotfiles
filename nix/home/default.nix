{ pkgs, ... }:
{
  imports = [
    ./modules/claude-code.nix
    ./modules/codex.nix
    ./modules/crane.nix
    ./modules/direnv.nix
    ./modules/fzf.nix
    ./modules/gh.nix
    ./modules/ghostty.nix
    ./modules/git.nix
    ./modules/go.nix
    ./modules/google-cloud-sdk.nix
    ./modules/karabiner-elements.nix
    ./modules/parallel.nix
    ./modules/raycast.nix
    ./modules/reviewdog.nix
    ./modules/terraform.nix
    ./modules/vscode.nix
    ./modules/zsh.nix
  ];

  home.packages = [ pkgs.gnumake ];
  home.stateVersion = "26.11";
}
