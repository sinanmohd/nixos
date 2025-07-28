{
  config,
  pkgs,
  lib,
  ...
}:
let
  host = config.networking.hostName;
in
{
  disabledModules = [
    "services/networking/pppd.nix"
  ];
  imports = [
    ./modules/nix.nix
    ./modules/user.nix
    ./modules/environment.nix
    ./modules/pppd.nix
    ./modules/home-manager.nix
    ../../global/common
  ];

  system.stateVersion = "24.05";
  time.timeZone = "Asia/Kolkata";

  networking = {
    useDHCP = false;
    hostName = lib.mkOptionDefault "common";
  };

  zramSwap.enable = true;
  swapDevices = lib.mkDefault [
    {
      device = "/swapfile";
      size = 2048; # 2GB
    }
  ];

  services.udev.extraRules =
    let
      cmd = "${pkgs.systemd}/bin/systemctl hibernate";
    in
    ''
      SUBSYSTEM=="power_supply", ATTR{status}=="Discharging", ATTR{capacity}=="[0-5]", RUN+="${cmd}"
    '';

  sops = {
    defaultSopsFile = ../${host}/secrets.yaml;
    age.keyFile = "/var/secrets/${host}.sops";
  };

  boot = {
    loader.timeout = 1;
    initrd.systemd.enable = true;
    tmp.cleanOnBoot = true;
  };

  programs.bash.promptInit = ''
    if [ "$UID" -ne 0 ]; then
        PROMPT_COLOR="1;32m"
    else
        PROMPT_COLOR="1;31m"
    fi

    PS1="\[\033[$PROMPT_COLOR\][\[\e]0;\u@\h: \w\a\]\u@\h:\w]\\$\[\033[0m\] "
  '';

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "nvidia-x11"
      "slack"
      "spotify"
    ];
}
