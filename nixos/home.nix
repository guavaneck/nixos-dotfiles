{ config, pkgs, ... }:

{
  home.username = "wyatt";
  home.homeDirectory = "/home/wyatt";
  
  home.packages = with pkgs; [
    firefox
    htop
    neofetch
  ];

  programs.git.settings = {
    enable = true;
    user.name = "guavaneck";
    user.email = "wszyjka@charlotte.edu";
  };
  
  programs.fish = {
    enable = true;
    shellAliases = {
      ll = "ls -la";
      update = "sudo nixos-rebuild switch --flake ~/dotfiles/nixos/#wyatt";
    };
    shellInit = ''
      set fish_greeting
    '';
  };
 
  programs.home-manager.enable = true;

  home.stateVersion = "25.11";
}
