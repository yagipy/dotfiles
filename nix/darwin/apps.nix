{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.ghostty-bin
    pkgs.raycast
  ];
}
