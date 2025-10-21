{ pkgs, ... }:
let
  wayland-scripts = pkgs.callPackage ../../wayland/pkgs/wayland-scripts { };
  freezshot = "${wayland-scripts}/bin/freezshot";
  scale = 1.6;
in
{
  wayland.windowManager.sway.settings = {
    # vendor hardcoded screenshot key
    bindsym."mod4+shift+s" = "exec ${freezshot}";

    output = {
      "eDP-1" = {
        inherit scale;
        position = "0,0";
      };
      "HDMI-A-1" = {
        inherit scale;
        position = "2560,0";
      };
    };
  };

  programs.bemenu.settings.line-height = 25;
}
