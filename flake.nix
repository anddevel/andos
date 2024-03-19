{

  description = "My first flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-23.11";
    kdenlive-pin-nixpkgs.url = "nixpkgs/cfec6d9203a461d9d698d8a60ef003cac6d0da94";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";
    nix-doom-emacs.inputs.nixpkgs.follows = "nixpkgs";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixpkgs-stable, kdenlive-pin-nixpkgs, home-manager, nix-doom-emacs, disko, ... }@inputs:
    let
      systemSettings = {
        system = "x86_64-linux";
        hostname = "andlappy";
        timezone = "Australia/Melbourne";
        locale = "en_AU.UTF-8";
        sysDisk = "/vda";
      };

      userSettings = rec {
        username = "anddevel";
        name = "andDEVEL";
        email = "webmin@anddevel.com";
        nixosDIR = "~/.andos";
        # theme = "catppuccino-mocha-teal"; future configuration if possible
        term = "alacritty";
        spawnEditor = "emacsclient -c -a 'emacs'";
      };

      pkgs = import nixpkgs {
        system = systemSettings.system;
        config = {
          allowUnfree = true;
        };
      };
      
      pkgs-stable = import nixpkgs-stable {
        system = systemSettings.system;
        config = {
          allowUnfree = true;
        };
      };

      pkgs-kdenlive = import kdenlive-pin-nixpkgs {
        system = systemSettings.system;
      };

      lib = nixpkgs.lib;
    in {

    nixosConfigurations = {
      system = lib.nixosSystem {
        system = systemSettings.system;
        modules = [
          disko.nixosModules.disko
          ./system/disko-config.nix
          ./system/configuration.nix 
        ];
        specialArgs = {
          inherit pkgs-stable;
          inherit systemSettings;
          inherit userSettings;
        };
      };
    };

    homeConfigurations = {
      anddevel = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./system/home.nix ];
        extraSpecialArgs = {
          inherit pkgs-stable;
          inherit pkgs-kdenlive;
          inherit systemSettings;
          inherit userSettings;
          inherit nix-doom-emacs;
        };
      };
      
    };
  };

}
