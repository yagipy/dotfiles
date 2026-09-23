{
  system,
  nix-darwin,
  home-manager,
  irisDotfiles,
}:
let
  mkDarwin =
    username:
    let
      homeDirectory = "/Users/${username}";
      dotfilesDir = "${homeDirectory}/dotfiles";
    in
    nix-darwin.lib.darwinSystem {
      modules = [
        home-manager.darwinModules.home-manager
        (
          { lib, ... }:
          {
            nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "claude-code" ];
          }
        )
        {
          nixpkgs.hostPlatform = system;
          nix = import ./nix.nix;
          system = import ./system.nix;
          users.users.${username}.home = homeDirectory;

          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "before-home-manager";
            extraSpecialArgs = { inherit dotfilesDir; };
            users.${username} = ../home;
          };
        }
      ];
    };
in
builtins.mapAttrs (username: _: mkDarwin username) irisDotfiles.machines
