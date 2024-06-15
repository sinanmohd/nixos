{ ... }: {
  programs.i3status = {
    enable = true;
    enableDefault = false;

    general = {
      output_format = "i3bar";
      separator = "";
      interval = 5;
    };

    modules = {
      "tztime local" = {
        position = 50;
        settings.format = "󱛡  %a,%e %b  %H:%M";
      };

      "battery all" = {
        position = 40;
        settings = {
          status_chr = "󰂄";
          status_bat = "󰂀";
          status_unk = "󰂃";
          status_full = "󱟨";
          last_full_capacity = true;
          low_threshold = 20;
          threshold_type = "percentage";
          format_percentage = "%.00f%s";
          path = "/sys/class/power_supply/BAT%d/uevent";
          format_down = "";
          format = "%status %percentage %remaining %consumption";
        };
      };

      "volume master" = {
        position = 50;
        settings = {
          format = "󰕾  %volume";
          format_muted = "󰖁  %volume";
        };
      };

      "cpu_temperature 0" = {
        position = 40;
        settings.format = "%degrees°C";
      };

      "cpu_usage" = {
        position = 30;
        settings.format = "  %usage";
      };

      "memory" = {
        position = 20;
        settings.format = "  %available";
      };

      "disk /" = {
        position = 10;
        settings.format = "󰋊  %avail";
      };

      "wireless _first_" = {
        position = 00;
        settings = {
          format_up = "󰤥  %quality";
          format_down = "";
        };
      };
    };
  };
}
