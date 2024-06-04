{ config, pkgs, lib, ... }:

let
  host = config.networking.hostName;
  user = config.global.userdata.name;
  email = config.global.userdata.email;
in
{
  disabledModules = [
    "services/networking/pppd.nix"
    "services/mail/stalwart-mail.nix"
  ];
  imports = [
    ./modules/tmux.nix
    ./modules/nix.nix

    ./modules/pppd.nix
    ./modules/stalwart-mail.nix
  ];

  system.stateVersion = "24.11";
  sops = {
    defaultSopsFile = ../${host}/secrets.yaml;
    age.keyFile = "/var/secrets/${host}.sops";
  };
  boot = {
    tmp.useTmpfs = true;
    loader.timeout = 1;
  };

  users.users.${user} = {
    uid = 1000;
    isNormalUser = true;
    description = email;
    extraGroups = [ "wheel" ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAcCendbKbeoc7hYEEcBt9wwtSXrJUgJ2SuYARO0zPAX sinan@veu"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL8LnyOuPmtKRqAZeHueNN4kfYvpRQVwCivSTq+SZvDU sinan@cez"
    ];
  };
  time.timeZone = "Asia/Kolkata";
  networking.useDHCP = false;

  environment = {
    binsh = lib.getExe pkgs.dash;
    systemPackages = with pkgs; [
      dash
      neovim
    ];

    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    shellAliases = {
      ls = "ls --color=auto --group-directories-first";
      grep = "grep --color=auto";
    };
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
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
