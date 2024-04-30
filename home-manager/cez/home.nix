{ ... }: let
  font = "Sans 13";
  monoFont = "monospace:size=18";
in {
  imports = [ ../wayland/home.nix ];

  services.mako.font = font;
  programs = {
    zathura.options.font = font;
    foot.settings.main.font = monoFont;
  };
}
