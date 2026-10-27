{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = null;
    profiles.default = {
      extensions = [
        pkgs.vscode-extensions.golang.go
        pkgs.vscode-extensions.hashicorp.terraform
        pkgs.vscode-extensions.jnoortheen.nix-ide
        pkgs.vscode-extensions.ms-python.python
        pkgs.vscode-extensions.ms-python.vscode-pylance
        pkgs.vscode-extensions.rust-lang.rust-analyzer
      ];
      userSettings = {
        "files.autoSave" = "afterDelay";
        "files.autoSaveDelay" = 1000;
      };
    };
  };
}
