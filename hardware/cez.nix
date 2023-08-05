{ config, ... }:

{
  imports = [
      ../features/wayland.nix
      ../features/kaysshfs.nix
      ../features/development.nix
  ];

  boot = {
    initrd.luks.reusePassphrases = true;
    consoleLogLevel = 3;
  };

  networking = {
    hostName = "cez";
    wireless.iwd.enable = true;
  };

  sound.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
}
