{ config, pkgs, ... }:

let
  user = config.userdata.user;
in
{
  imports = [
    ./hardware-configuration.nix
    ./modules/wayland.nix
    ./modules/sshfs.nix
    ./modules/wireguard.nix
    ../../common.nix
  ];

  boot = {
    initrd.luks.reusePassphrases = true;
    consoleLogLevel = 3;
    kernelPackages = pkgs.linuxPackages_latest;
  };
  sound = {
    enable = true;
    extraConfig = ''
      defaults.pcm.card 1
      defaults.ctl.card 1
    '';
  };

  networking = {
    hostName = "cez";
    useDHCP = false;
    firewall.enable = false;

    wireless.iwd = { 
      enable = true;
      settings = {
        General.EnableNetworkConfiguration = true;
        Network.NameResolvingService = "resolvconf";
      };
    };
  };

  services = {
    getty.autologinUser = user;
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
    openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
    };
  };
}
