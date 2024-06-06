{ pkgs, ... }: {
  dconf.enable = false;

  gtk = {
    enable = true;
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
  };

  home.pointerCursor = {
    gtk.enable = true;

    name = "Adwaita";
    package = pkgs.gnome.adwaita-icon-theme;
  };
}
