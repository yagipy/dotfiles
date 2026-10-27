{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = null;
    profiles.default = {
      extensions = [ pkgs.vscode-extensions.jnoortheen.nix-ide ];
      userSettings = {
        "files.autoSave" = "afterDelay";
        "files.autoSaveDelay" = 1000;
      };
    };
  };
}
