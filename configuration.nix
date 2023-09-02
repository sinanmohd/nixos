{ config, pkgs, lib, ... }:

let
  user = config.userdata.user;
  groups = config.userdata.groups;
in
{
  imports = [
    ./hardware-configuration.nix # hw scan
    ./modules/userdata.nix
    ./hosts/cez.nix
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

  # users
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "adbusers"
    ] ++ groups;
    packages = with pkgs; [
      yt-dlp
      geoipWithDatabase
      dig
      nnn
      ffmpeg
      rtorrent
      ps_mem
      brightnessctl
    ];
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
    ];
  };
  system.stateVersion = "23.05";

  # nix
  nix.settings.experimental-features = [
      "nix-command"
      "flakes"
  ];
  nixpkgs.overlays = with builtins; lib.mkIf (pathExists ./overlays) (
    map
      (overlay: import ./overlays/${overlay})
      (attrNames (readDir ./overlays))
  );

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
