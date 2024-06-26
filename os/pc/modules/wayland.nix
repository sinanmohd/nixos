{ config, ... }: let
  user = config.global.userdata.name;

  fontSans = config.global.font.sans.name;
  fontMonospace = config.global.font.monospace.name;
  fontPackages = config.global.font.monospace.packages
    ++ config.global.font.sans.packages;
in {
  fonts = {
    packages = fontPackages;
    enableDefaultPackages = true;

    fontconfig = {
      hinting.style = "full";
      subpixel.rgba = "rgb";

      defaultFonts = {
        monospace = [ fontMonospace ];
        serif = [ fontSans ];
        sansSerif = [ fontSans ];
      };
    };
  };

  users.users.${user}.extraGroups = [ "seat" ];
  services = {
    seatd.enable = true;
    dbus = {
      enable = true;
      implementation = "broker";
    };
  };

  hardware.graphics.enable = true;
  security.pam.services.swaylock = {};
}
