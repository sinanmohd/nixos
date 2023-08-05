{ config, pkgs, ... }:

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
