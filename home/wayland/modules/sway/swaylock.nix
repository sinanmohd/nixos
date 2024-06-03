{ pkgs, ... }: {
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;

    settings = {
      clock = true;
      daemonize = true;
      color = "404040";
      timestr = "%H:%M";
      datestr = "%a,%e %b";
      indicator-idle-visible = true;
    };
  };
}
