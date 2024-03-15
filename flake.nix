{

  description = "My first flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";
  };

  outputs = { self, nixpkgs, home-manager, nix-doom-emacs, disko, ... }@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {

    nixosConfigurations = {
      andLappy = lib.nixosSystem {
        inherit system;
        specialArgs.inputs = inputs;
        modules = [
          disko.nixosModules.disko
          ./system/disko-config.nix
          ./system/configuration.nix 
        ];
      };
    };

    homeConfigurations = {
      anddevel = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./users/home.nix ];
      };
      
    };
  };

}
