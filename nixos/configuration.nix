
{ config, lib, pkgs, ... }:

{
  imports =
    [  
     ./hardware-configuration.nix
    ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
    default = 0;
    extraEntries = ''
    menuentry "CachyOS" {
      search --set=root --fs-uuid 7246bc39-e5e0-45ac-b33c-ecd2e59c8ab0
      configfile /grub/grub.cfg
    }
    '';

  };
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "wyatt";
  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";
  
  services.pipewire.enable = false;
  services.pulseaudio.enable = true;
  services.displayManager.ly.enable = true;

  users.users.wyatt = {
    isNormalUser = true;
    extraGroups = [ "wheel"  "networkmanager" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;
  programs.firefox.enable = true;
  programs.niri.enable = true; 

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    git
    wget
    alacritty
    fuzzel
    fastfetch
    ly
    efibootmgr
    os-prober
  ];

  system.stateVersion = "25.11"; # Did you read the comment?

}

