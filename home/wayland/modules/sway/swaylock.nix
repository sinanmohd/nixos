{ config, pkgs, ... }: let
  background = "${config.xdg.dataHome}/wayland/lockscreen";
in {
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects.overrideAttrs {
      depsBuildBuild = [ pkgs.pkg-config ];
    };

    settings = {
      clock = true;
      daemonize = true;
      color = "404040";
      timestr = "%H:%M";
      datestr = "%a,%e %b";
      image = background;
      indicator-idle-visible = true;
    };
  };
}
