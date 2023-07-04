{ config, pkgs, ... }:

let
  user = "sinan";
in
{
  imports =
    [
      ./hardware-configuration.nix # hw scan
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
      android-tools
      geoipWithDatabase
      dig
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
      dash
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
  nix.settings.experimental-features = [ "nix-command" ];

  programs.bash.promptInit = ''
    PROMPT_COLOR="1;31m"
    [ "$UID" -ne 0 ] &&
      PROMPT_COLOR="1;32m"

    PS1="\[\033[$PROMPT_COLOR\][\[\e]0;\u@\h: \w\a\]\u@\h:\w]\\$\[\033[0m\] "
  '';
}
