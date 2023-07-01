{ config, pkgs, ... }:

let
  user = "sinan";
in
{
  imports =
    [ # include the results of the hardware scan.
      ./hardware-configuration.nix
      ./hardware/cez.nix
      ./features/wayland.nix
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
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      nnn
      shellcheck
      ffmpeg-full
      gnumake
      rtorrent
      nixos-option
      pass
      gcc
      neofetch
      ps_mem
      brightnessctl
    ];
  };
  services.getty.autologinUser = user;

  # system
  environment = {
    binsh = "${pkgs.dash}/bin/dash";
    systemPackages = with pkgs; [
      unzip
      bc
      file
      openssl
      git
      htop
      curl
      neovim
      wget
      tree
    ];
  };
  system.stateVersion = "23.05";
}
