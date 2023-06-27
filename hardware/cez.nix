{ config, ... }:

{
  # netwroking
  networking = {
    hostName = "cez";
    wireless.iwd.enable = true;
  };

  # fde
  boot.initrd.luks.reusePassphrases = true;
}
