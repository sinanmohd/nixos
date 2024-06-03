{ ... }: {
  programs.i3status = {
    enable = true;
    enableDefault = false;

    general = {
      output_format = "i3bar";
      separator = "";
      interval = 5;
      colors = false;
    };

    modules = {
      "tztime local" = {
        position = 30;
        settings.format = "󱛡   %a,%e %b  %H:%M";
      };
      "volume master" = {
        position = 20;
        settings = {
          format = "󰕾  %volume";
          format_muted = "󰖁  %volume";
        };
      };
      "memory" = {
        position = 10;
        settings.format = "  %available";
      };
      "disk /" = {
        position = 00;
        settings.format = "󰋊   %avail";
      };
    };
  };
}
