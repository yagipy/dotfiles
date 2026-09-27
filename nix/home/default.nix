{ ... }:
{
  imports = [
    ./modules/claude-code.nix
    ./modules/codex.nix
    ./modules/direnv.nix
    ./modules/fzf.nix
    ./modules/gh.nix
    ./modules/ghostty.nix
    ./modules/git.nix
    ./modules/go.nix
    ./modules/parallel.nix
    ./modules/raycast.nix
    ./modules/reviewdog.nix
    ./modules/terraform.nix
    ./modules/zsh.nix
  ];

  home.stateVersion = "26.11";
}
