{
  config,
  pkgs,
  lib,
  ...
}:
let
  user = config.global.userdata.name;
in
{
  imports = [
    ../common/configuration.nix

    ./modules/getty.nix
    ./modules/sshfs.nix
    ./modules/network.nix
    ./modules/wayland.nix
    ./modules/nopolkit.nix
    ./modules/nocodb.nix
    ./modules/firejail.nix
  ];

  networking.hostName = lib.mkDefault "pc";

  boot = {
    consoleLogLevel = 3;
    kernelPackages = pkgs.linuxPackages_latest;
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  documentation.dev.enable = true;
  programs.adb.enable = true;
  users.users.${user}.extraGroups = [ "adbusers" ];
}
