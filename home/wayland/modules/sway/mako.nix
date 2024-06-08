{ config, pkgs, lib, ... }: let
  font = config.global.font.sans.name
    + lib.optionalString (config.global.font.sans.size != null)
      " " + builtins.toString config.global.font.sans.size;
in {
  home.packages = with pkgs; [ libnotify ];

  services.mako = {
    enable = true;
    defaultTimeout = 3000;

    inherit font;
    borderSize = 2;
    backgroundColor = "#000000";
  };
}
