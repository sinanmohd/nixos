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

  # networking
  time.timeZone = "Asia/Kolkata";

  # sound
  sound.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # users
  users.users.sinan = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      w3m
      neofetch
      ps_mem
    ];
  };
  services.getty.autologinUser = "sinan";

  # system
  environment.systemPackages = with pkgs; [
    tmux
    file
    openssl
    git
    htop
    curl
    neovim
    wget
  ];
  system.stateVersion = "23.05";
}
