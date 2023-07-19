{ config, ... }:

{
  imports = [
      ../features/wayland.nix
      ../features/kaysshfs.nix
      ../features/development.nix
  ];

  networking = {
    hostName = "cez";
    wireless.iwd.enable = true;
  };

  boot = {
    initrd.luks.reusePassphrases = true;
    consoleLogLevel = 3;
  };
}
