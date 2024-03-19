{ config, pkgs, pkgs-kdenlive, nix-doom-emacs, userSettings, ... }:

{
  home.username = userSettings.username;
  home.homeDirectory = "/home/"+userSettings.username;

  programs.home-manager.enable = true;

  imports = [ 
    nix-doom-emacs.hmModule
    ../../users/sh.nix #shell config
    ../../users/doom.nix
  ];
  
  home.stateVersion = "23.11";

  home.packages = (with pkgs; [
    alacritty
    google-chrome
    git
    vim
    gimp
    pinta
    krita
    inkscape
    vlc
    mpv
    yt-dlp
    ffmpeg
  ]) ++ ([ pkg-kdenlive.kdenlive ]);

  home.sessionVariables = {
    EDITOR = "emacs";
    SPAWNEDITOR = userSettings.spawnEditor;
    TERM = userSettings.term;
  };
}
