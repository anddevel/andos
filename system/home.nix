{ config, pkgs, pkgs-kdenlive, nix-doom-emacs, userSettings, ... }:

{
  home.username = userSettings.username;
  home.homeDirectory = "/home/"+userSettings.username;

  programs.home-manager.enable = true;

  imports = [ 
    ../users/sh.nix #shell config
  ];
  
  home.stateVersion = "23.11";

  home.packages = (with pkgs; [
    alacritty
    emacs-gtk
    gh-markdown-preview
    shellcheck
    fd
    ripgrep
    nixfmt
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
  ]) ++ ([ pkgs-kdenlive.kdenlive ]);

  home.sessionVariables = {
    EDITOR = "emacs";
    SPAWNEDITOR = userSettings.spawnEditor;
    TERM = userSettings.term;
  };
}
