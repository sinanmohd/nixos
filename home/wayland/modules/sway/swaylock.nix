{ pkgs, ... }: {
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;

    settings = {
      clock = true;
      timestr = "%H:%M";
      datestr = "%a,%e %b";
      indicator-idle-visible = true;
      color = "404040";
    };
  };
}
