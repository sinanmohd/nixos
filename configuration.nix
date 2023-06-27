{ config, pkgs, ... }:

{
  imports =
    [ # include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # boot
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # netwroking
  networking = {
    hostName = "cez";
    wireless.iwd.enable = true;
  };
  time.timeZone = "Asia/Kolkata";

  # sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # users
  users.users.sinan = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      git
      tmux
      w3m
      neofetch
    ];
  };
  services.getty.autologinUser = "sinan";

  # system
  environment.systemPackages = with pkgs; [
    htop
    curl
    neovim
    wget
  ];
  system.stateVersion = "23.05";
}
