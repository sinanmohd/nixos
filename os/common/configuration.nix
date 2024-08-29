{ config, lib, ... }: let
  host = config.networking.hostName;
in {
  disabledModules = [
    "services/networking/pppd.nix"
    "services/mail/stalwart-mail.nix"
  ];
  imports = [
    ./modules/nix.nix
    ./modules/user.nix
    ./modules/environment.nix

    ./modules/pppd.nix
    ./modules/stalwart-mail.nix
  ];

  system.stateVersion = "24.11";
  time.timeZone = "Asia/Kolkata";
  networking.useDHCP = false;

  swapDevices = lib.mkDefault [{
    device = "/swapfile";
    size = 2048; # 2GB
  }];

  sops = {
    defaultSopsFile = ../${host}/secrets.yaml;
    age.keyFile = "/var/secrets/${host}.sops";
  };

  boot = {
    tmp.useTmpfs = true;
    loader.timeout = 1;
  };

  programs.bash.promptInit = ''
    if [ "$UID" -ne 0 ]; then
        PROMPT_COLOR="1;32m"
    else
        PROMPT_COLOR="1;31m"
    fi

    PS1="\[\033[$PROMPT_COLOR\][\[\e]0;\u@\h: \w\a\]\u@\h:\w]\\$\[\033[0m\] "
  '';
}
