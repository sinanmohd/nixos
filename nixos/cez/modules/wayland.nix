{ config, pkgs, lib, ... }:

let
  user = config.userdata.name;
in
{
  # pkgs
  environment.systemPackages = with pkgs; [
    bemenu
    sway
    i3status
    swaylock
    swayidle
    swaybg
    foot
    wl-clipboard
    mako
    xdg-utils
    libnotify
  ];

  users.users.${user} = {
    extraGroups = [ "seat" ];
    packages = with pkgs; [
      zathura
      mpv
      imv
      wtype
      qemu
      OVMFFull
      grim
      slurp
      tor-browser-bundle-bin
      element-desktop-wayland
      pinentry-bemenu
    ];
  };

  # font
  fonts = {
    packages = with pkgs; [
      terminus-nerdfont
      dm-sans
    ];
    enableDefaultPackages = true;
    fontconfig = {
      hinting.style = "full";
      subpixel.rgba = "rgb";
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
    gnupg.agent = {
      enable = true;
      settings.pinentry-program = lib.mkForce "${pkgs.pinentry-bemenu}/bin/pinentry-bemenu";
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
