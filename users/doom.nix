{ config, lib, pkgs, pkgs-stable, userSettings, systemSettings, ... }:

{
  programs.doom-emacs = {
    enable = true;
    emacsPackage = pkgs.emacs29-pgtk;
    doomPrivateDir = ./.;
    doomPackageDir = let
      filteredPath = builtins.path {
        path = ./.;
        name = "doom-private-dir-filtered";
        filter = path: type:
          builtins.elem (baseNameOf path) [ "init.el" "packages.el" ];
      };
      in pkgs.linkFarm "doom-packages-dir" [
        {
          name = "init.el";
          path = "${filteredPath}/init.el";
        }
        {
          name = "packages.el";
          path = "${filteredPath}/packagaes.el";
        }
        {
          name = "config.el";
          path = pkgs.emptyFile;
        }
      ];
  };

}
