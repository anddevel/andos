{ config, pkgs, ... }:

let
  myAliases = {
    al = "ls -la";
    ll = "ls -l";
    ".." = "cd ..";
  };
in

{
  programs.bash = {
    enable = true;
    shellAliases = myAliases;
  };  
}
