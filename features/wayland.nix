{ config, pkgs, lib, ... }:

let
  # https://github.com/emersion/xdg-desktop-portal-wlr/wiki/"It-doesn't-work"-Troubleshooting-Checklist
  dbus-xdp-environment = pkgs.writeTextFile {
    name = "dbus-xdp-environment";
    destination = "/bin/dbus-xdp-environment";
    executable = true;

    text =
      ''
        dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots
        systemctl --user stop pipewire wireplumber xdg-desktop-portal xdg-desktop-portal-wlr
        systemctl --user start pipewire wireplumber xdg-desktop-portal xdg-desktop-portal-wlr
      '';
  };

  # gtk theming: https://github.com/swaywm/sway/wiki/GTK-3-settings-on-Wayland
  # for gsettings to work, we need to tell it where the schemas are
  # using the XDG_DATA_DIR environment variable
  configure-gtk = pkgs.writeTextFile {
      name = "configure-gtk";
      destination = "/bin/configure-gtk";
      executable = true;
      text = let
        schema = pkgs.gsettings-desktop-schemas;
        datadir = "${schema}/share/gsettings-schemas/${schema.name}";
      in
        ''
          export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
          gnome_schema=org.gnome.desktop.interface
          gsettings set $gnome_schema gtk-theme 'Dracula'
        '';
  };
in
{
  # pkgs
  environment.systemPackages = with pkgs; [
    (dwl.overrideAttrs (oldAttrs: {
      name = "dwl@git.sinanmohd.com";
      src = fetchgit {
        url = "https://git.sinanmohd.com/dwl";
	rev = "2edd9f1448d4d8641c3cff3b0112694d2636241c";
	sha256 = "1wns3g7r7g5gcc8vcrffrvvx1cfp33myb80l0p6pv6qaflvb5i0a";
      };
    }))
    pinentry-gnome
    mpv
    qemu
    OVMFFull
    element-desktop
    firefox
    dbus-xdp-environment
    swaylock
    swayidle
    swaybg
    foot
    grim
    slurp
    wl-clipboard
    wmenu
    mako
    wayland
    xdg-utils
    imv
    libnotify
    wob
    wlr-randr
    nerdfonts
    tor-browser-bundle-bin
    wtype
    # gtk
    configure-gtk
    dracula-theme # gtk theme
    gnome3.adwaita-icon-theme  # default gnome cursors
    glib # gsettings
  ];

  # xdg desktop portal
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # misc
  security.polkit.enable = true;
  hardware.opengl.enable = true;
  fonts.enableDefaultFonts = true;
  programs.dconf.enable = true;
  programs.xwayland.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "gnome3";
  };
}
