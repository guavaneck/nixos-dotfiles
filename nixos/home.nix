{ config, pkgs, ... }:

{
  home.username = "wyatt";
  home.homeDirectory = "/home/wyatt";
  
  home.packages = with pkgs; [
    firefox
    htop
    neofetch
  ];

  programs.git = {
    enable = true;
    userName = "guavaneck";
    userEmail = "wszyjka@charlotte.edu";
  };
  
  programs.fish = {
    enable = true;
    shellAliases = {
      ll = "ls -la";
      update = "sudo nixos-rebuild switch --flake ~/#wyatt";
    };
    shellInit = ''
      set fish_greeting
    '';
  };
 
  programs.home-manager.enable = true;

  home.stateVersion = "25.11";
}
