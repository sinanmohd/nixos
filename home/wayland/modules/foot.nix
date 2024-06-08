{ config, lib, ... }: let
  font = config.global.font.monospace.name
    + lib.optionalString (config.global.font.monospace.size != null)
      ":size=" + builtins.toString config.global.font.monospace.size;
in {
  programs.foot = {
    enable = true;

    settings = {
      colors.background = "000000";
      main = {
        inherit font;
        pad = "10x10";
      };
    };
  };
}
