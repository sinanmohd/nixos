{ pkgs, ... }: let
  wayland-scripts = pkgs.callPackage ../../wayland/pkgs/wayland-scripts {};
  freezshot = "${wayland-scripts}/bin/freezshot";
in {
  wayland.windowManager.sway.settings = {
    # vendor hardcoded screenshot key
    bindsym."mod4+shift+s" = "exec ${freezshot}";

    output = {
      "eDP-1".scale = 1.6;
      "HDMI-A-1".scale = 1.6;
    };
  };

  programs.bemenu.settings.line-height = 25;
}
