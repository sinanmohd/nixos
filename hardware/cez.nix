{ config, ... }:

{
  networking = {
    hostName = "cez";
    wireless.iwd.enable = true;
  };

  boot = {
    initrd.luks.reusePassphrases = true;
    consoleLogLevel = 3;
  };
}
