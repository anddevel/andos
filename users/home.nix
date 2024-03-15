{ config, pkgs, ... }:

{
  imports = [
    ./sh.nix
  ];

  home.username = "anddevel";
  home.homeDirectory = "/home/anddevel";

  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = [
  ];

  home.file = {
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.home-manager.enable = true;
}
