{ config, pkgs, ... }:

let
  user = config.userdata.user;
in
{
  imports = [
    ../common/configuration.nix
    ./hardware-configuration.nix

    ./modules/wayland.nix
    ./modules/sshfs.nix
    ./modules/wireguard.nix
    ./modules/network.nix
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
    getty.autologinUser = user;
  };

  programs.adb.enable = true;
  users.users.${user} = {
    extraGroups = [ "adbusers" ];
    packages = with pkgs; [
      geoipWithDatabase
      ffmpeg
      (pass.withExtensions (exts: [ exts.pass-otp ]))
    ];
  };
}
