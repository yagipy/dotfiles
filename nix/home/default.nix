{ ... }:
{
  imports = [
    ./modules/claude-code.nix
    ./modules/gh.nix
    ./modules/git.nix
    ./modules/zsh.nix
  ];

  home.stateVersion = "26.11";
}
