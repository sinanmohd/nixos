{ config, pkgs, ... }:

{
  imports = [ ./seatd.nix ];

  # pkgs
  environment.systemPackages = with pkgs; [
    dwl-sinan
    wmenu-sinan
    pinentry-gnome
    swaylock
    swayidle
    swaybg
    foot
    wl-clipboard
    mako
    wayland
    xdg-utils
    libnotify
    wob
    wlr-randr
  ];
  users.users.${config.passthru.user}.packages = with pkgs; [
    zathura
    mpv
    imv
    wtype
    tor-browser-bundle-bin
    qemu
    OVMFFull
    element-desktop
    grim
    slurp
  ];

  # font
  fonts = {
    packages = with pkgs; [
      terminus-nerdfont
      dm-sans
    ];
    enableDefaultPackages = true;
    fontconfig = {
      hinting.style = "full";
      defaultFonts = {
        monospace = [ "Terminess Nerd Font" ];
        serif = [ "DeepMind Sans" ];
        sansSerif = [ "DeepMind Sans" ];
      };
    };
  };

  # misc
  services = {
    seatd.enable = true;
    dbus = {
      implementation = "broker";
      enable = true;
    };
  };

  programs = {
    xwayland.enable = true;
    gnupg.agent = {
      enable = true;
      pinentryFlavor = "gnome3";
    };
    firefox = {
      enable = true;
      preferences = {
        "media.ffmpeg.vaapi.enabled" = true;
        "gfx.webrender.all" = true;
        "identity.fxaccounts.enabled" = false;
      };
    };
  };

  security.pam.services.swaylock.text = "auth include login";
  hardware.opengl.enable = true;
}
