{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    unzip
    zenity
    xdg-desktop-portal-gtk
    brightnessctl 
    neovim
  ];
}
