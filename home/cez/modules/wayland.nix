{ pkgs, ... }: let
  wayland-scripts = pkgs.callPackage ../../wayland/pkgs/wayland-scripts {};
  freezshot = "${wayland-scripts}/bin/freezshot";
in {
  # vendor hardcoded screenshot key
  wayland.windowManager.sway.settings.bindsym."mod4+shift+s" =
    "exec ${freezshot}";

  programs.bemenu.settings.line-height = 30;
}
