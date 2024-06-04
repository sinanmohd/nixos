{ config, pkgs, ... }: let
  user = config.global.userdata.name;
in {
  imports = [
    ../common/configuration.nix

    ./modules/getty.nix
    ./modules/sshfs.nix
    ./modules/network.nix
    ./modules/wayland.nix
  ];

  boot = {
    consoleLogLevel = 3;
    kernelPackages = pkgs.linuxPackages_latest;
  };

  sound.enable = true;
  services.pipewire = {
      enable = true;
      pulse.enable = true;
  };

  documentation.dev.enable = true;
  programs.adb.enable = true;
  users.users.${user}.extraGroups = [ "adbusers" ];
}
