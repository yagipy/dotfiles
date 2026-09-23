{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    irisDotfiles.url = "git+https://github.com/yagipy/iris?dir=dotfiles";
  };

  outputs =
    {
      nixpkgs,
      nix-darwin,
      home-manager,
      irisDotfiles,
      ...
    }:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      formatter.${system} = import ./nix/formatter { inherit pkgs; };
      darwinConfigurations = import ./nix/darwin {
        inherit
          system
          nix-darwin
          home-manager
          irisDotfiles
          ;
      };
    };
}
