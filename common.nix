{ config, pkgs, lib, ... }:

let
  host = config.networking.hostName;
  user = config.userdata.user;
in
{
  disabledModules = [
    "services/networking/pppd.nix"
  ];
  imports = [
    ./modules/userdata.nix

    ./modules/tmux.nix
    ./modules/dev.nix

    ./modules/pppd.nix
  ];

  sops = {
    defaultSopsFile = ./hosts/${host}/secrets.yaml;
    age.keyFile = "/var/secrets/${host}.sops";
  };
  system.stateVersion = "23.11";
  nix.settings.experimental-features = [ "flakes" "nix-command" ];

  boot = {
    tmp.useTmpfs = true;
    loader = {
      timeout = 1;
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  users.users.${user} = {
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      bc
      unzip
      htop
      curl
      file
      dig
      mtr
      nnn
      ps_mem
      brightnessctl
    ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDCeMXhkjm9CabbA/1xdtP9bvFEm8pVXPk66NmI9/VvQ sinan@vex"
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
