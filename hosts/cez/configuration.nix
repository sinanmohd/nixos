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
    ./modules/network.nix
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

  services = {
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
    openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
    };
    getty.autologinUser = user;
  };
}
