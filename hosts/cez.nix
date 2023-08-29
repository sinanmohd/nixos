{ ... }:

{
  imports = [
    ../modules/wayland.nix
    ../modules/kaysshfs.nix
    ../modules/dev.nix
  ];

  boot = {
    initrd.luks.reusePassphrases = true;
    consoleLogLevel = 3;
  };

  networking = {
    hostName = "cez";
    dhcpcd.wait = "background";
    wireless.iwd.enable = true;
  };

  sound = {
    enable = true;
    extraConfig = ''
      defaults.pcm.card 1
      defaults.ctl.card 1
    '';
  };
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
}
