{ config, pkgs, ... }:

let
  user = config.userdata.user;
in
{
  imports = [
    ./hardware-configuration.nix
    ./modules/wayland.nix
    ./modules/sshfs.nix
    ../../common.nix
  ];

  nixpkgs.overlays = [
    (import ./overlays/wmenu.nix)
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
    dhcpcd.wait = "background";
    wireless.iwd.enable = true;
  };

  services = {
    getty.autologinUser = user;
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
  };
}
