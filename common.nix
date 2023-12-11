{ config, pkgs, ... }:

let
  user = config.userdata.user;
  groups = config.userdata.groups;
  description = config.userdata.email;
  pubKeys = config.userdata.pubKeys;
  host = config.networking.hostName;
in
{
  disabledModules = [ "services/networking/pppd.nix" ];
  imports = [
    ./modules/userdata.nix
    ./modules/dev.nix
    ./modules/pppd.nix
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

  # users
  users.users.${user} = {
    inherit description;
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
      neofetch
      (pass.withExtensions (exts: [ exts.pass-otp ]))
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
      luajit
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
  system.stateVersion = "23.11";
  time.timeZone = "Asia/Kolkata";

  # nix
  nix.settings.experimental-features = [
    "flakes"
    "nix-command"
  ];

  # sops
  sops = {
    defaultSopsFile = ./hosts/${host}/secrets.yaml;
    age.keyFile = "/var/secrets/sops.key";
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
