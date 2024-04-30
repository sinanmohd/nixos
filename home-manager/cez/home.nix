{ ... }: let
  font = "Sans 13";
in {
  imports = [ ../wayland/home.nix ];

  services.mako.font = font;
  programs.zathura.options.font = font;
}
