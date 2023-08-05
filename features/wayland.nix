{ config, pkgs, ... }:

let
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
    dwl-sinan
    zathura
    pinentry-gnome
    mpv
    qemu
    OVMFFull
    element-desktop
    firefox
    swaylock
    swayidle
    swaybg
    foot
    grim
    slurp
    wl-clipboard
    wmenu-sinan
    mako
    wayland
    xdg-utils
    imv
    libnotify
    wob
    wlr-randr
    tor-browser-bundle-bin
    wtype
    configure-gtk
    dracula-theme # gtk theme
    glib # gsettings
  ];

  # font
  fonts = {
    fonts = [ pkgs.terminus-nerdfont pkgs.dm-sans ];
    enableDefaultFonts = true;
    fontconfig = {
      hinting.style = "hintfull";
      defaultFonts = {
        monospace = [ "Terminess Nerd Font" ];
        serif = [ "DeepMind Sans" ];
        sansSerif = [ "DeepMind Sans" ];
      };
    };
  };

  # misc
  hardware.opengl.enable = true;

  services.dbus.enable = true;
  programs = {
    dconf.enable = true;
    xwayland.enable = true;
    gnupg.agent = {
      enable = true;
      pinentryFlavor = "gnome3";
    };
  };

  security = {
    polkit.enable = true;
    pam.services.swaylock.text = "auth include login";
  };
}
