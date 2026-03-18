{ config, lib, pkgs, ... }:

{
  imports =
    [  
     ./hardware-configuration.nix
     ./packages.nix
    ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
    default = 0;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "wyatt";
  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";

  services.pulseaudio.enable = false;

  security.rtkit.enable = true; 
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.pipewire.extraConfig.pipewire."92-low-latency" = {
    "context.properties" = {
      "default.clock.rate" = 48000;
      "default.clock.quantum" = 32;
      "default.clock.min-quantum" = 32;
      "default.clock.max-quantum" = 32;
    };
  };

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
    pavucontrol 
    yazi 
  ];

  systemd.user.services.nixos-config-autopush = {
    description = "Auto-push dotfiles to GitHub";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash /home/wyatt/dotfiles/auto-push.sh";
    };
  };

  systemd.user.timers.nixos-config-autopush = {
    description = "Timer for auto-pushing dotfiles on boot";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "5min";
      Persistent = true;
    };
  };

  system.stateVersion = "25.11"; # Did you read the comment?

}

