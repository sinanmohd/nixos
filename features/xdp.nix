{ config, pkgs, ... }:

let
  # https://github.com/emersion/xdg-desktop-portal-wlr/wiki/"It-doesn't-work"-Troubleshooting-Checklist
  dbus-xdp-environment = pkgs.writeTextFile {
    name = "dbus-xdp-environment";
    destination = "/bin/dbus-xdp-environment";
    executable = true;

    text = ''
        dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots
        systemctl --user stop pipewire wireplumber xdg-desktop-portal xdg-desktop-portal-wlr
        systemctl --user start pipewire wireplumber xdg-desktop-portal xdg-desktop-portal-wlr
    '';
  };
in
{
  # pkgs
  environment.systemPackages = [ dbus-xdp-environment ];

  # xdg desktop portal
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
