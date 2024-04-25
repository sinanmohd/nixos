{ config, pkgs, lib, ... }:

let
  host = config.networking.hostName;
  user = config.userdata.name;
  email = config.userdata.email;
in
{
  disabledModules = [
    "services/networking/pppd.nix"
    "services/mail/stalwart-mail.nix"
  ];
  imports = [
    ./modules/tmux.nix
    ./modules/dev.nix
    ./modules/nix.nix

    ./modules/pppd.nix
    ./modules/stalwart-mail.nix
  ];

  sops = {
    defaultSopsFile = ../${host}/secrets.yaml;
    age.keyFile = "/var/secrets/${host}.sops";
  };
  system.stateVersion = "23.11";
  nix.settings.experimental-features = [ "flakes" "nix-command" ];

  boot = {
    tmp.useTmpfs = true;
    loader.timeout = 1;
  };

  users.users.${user} = {
    uid = 1000;
    isNormalUser = true;
    description = email;

    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      bc
      unzip
      htop
      curl
      file
      dig
      tcpdump
      mtr
      nnn
      ps_mem
      brightnessctl
    ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAcCendbKbeoc7hYEEcBt9wwtSXrJUgJ2SuYARO0zPAX sinan@veu"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL8LnyOuPmtKRqAZeHueNN4kfYvpRQVwCivSTq+SZvDU sinan@cez"
    ];
  };

  time.timeZone = "Asia/Kolkata";
  networking.useDHCP = false;
  environment = {
    binsh = "${lib.getExe pkgs.dash}";
    systemPackages = with pkgs; [
      dash
      luajit
      neovim
      sops
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
