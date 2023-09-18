{ config, pkgs, lib, ... }:

let
  user = config.userdata.user;
  groups = config.userdata.groups;
  description = config.userdata.description;
  pubKeys = config.userdata.pubKeys;
  host = config.networking.hostName;
in
{
  disabledModules = [
    "services/networking/pppd.nix"
    "system/boot/systemd/logind.nix"
  ];
  imports = [
    ./modules/userdata.nix
    ./modules/dev.nix
    ./modules/pppd.nix
    ./modules/seatd.nix
    ./modules/logind.nix
  ];

  # boot
  boot = {
    tmp.useTmpfs = true;
    loader = {
      timeout = 1;
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  # networking
  time.timeZone = "Asia/Kolkata";
  networking.useDHCP = lib.mkDefault true;

  # users
  users.users.${user} = {
    description = description;
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "adbusers"
    ] ++ groups;
    packages = with pkgs; [
      pass
      yt-dlp
      geoipWithDatabase
      dig
      nnn
      ffmpeg
      rtorrent
      ps_mem
      brightnessctl
      neofetch
    ];
    openssh.authorizedKeys.keys = pubKeys;
  };

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
      git
      htop
      curl
      neovim
      age
      sops
    ];
  };
  system.stateVersion = "23.05";

  # nix
  nix.settings.experimental-features = [
    "flakes"
    "nix-command"
  ];
  nixpkgs.overlays = [
    (import ./overlays/dwl-sinan.nix)
    (import ./pkgs)
  ];

  # sops
  sops = {
    defaultSopsFile = ./hosts/${host}/secrets.yaml;
    age.keyFile = "/var/secrets/sops-nix/keys.txt";
  };

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
