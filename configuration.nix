{ config, pkgs, options, ... }:

let
  user = "sinan";
in
{
  imports = [
      ./hardware-configuration.nix # hw scan
      ./hardware/cez.nix
  ];

  # boot
  boot = {
    tmp.useTmpfs = true;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  # networking
  time.timeZone = "Asia/Kolkata";

  # sound
  sound.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # users
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "adbusers" ];
    packages = with pkgs; [
      yt-dlp
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
      lua
      luajit
      neofetch
      ps_mem
      brightnessctl
    ];
  };
  services.getty.autologinUser = user;

  # system
  environment = {
    binsh = "${pkgs.dash}/bin/dash";
    shellAliases = {
      ls = "ls --color=auto --group-directories-first";
      grep = "grep --color=auto";
    };
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
  services.dbus.implementation = "broker";

  # nix
  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    nixPath =
      options.nix.nixPath.default ++
      [ "nixpkgs-overlays=/etc/nixos/overlays/" ]
    ;
  };
  nixpkgs.overlays = with builtins;
    if pathExists ./overlays then
      map
        (overlay: import ./overlays/${overlay})
        (attrNames (readDir ./overlays))
    else
      options.nixpkgs.overlays.default
  ;

  # programs
  programs = {
    adb.enable = true;
    bash.promptInit = ''
      PROMPT_COLOR="1;31m"
      [ "$UID" -ne 0 ] &&
        PROMPT_COLOR="1;32m"

      PS1="\[\033[$PROMPT_COLOR\][\[\e]0;\u@\h: \w\a\]\u@\h:\w]\\$\[\033[0m\] "
    '';
  };
}
