{ pkgs, ... }:
{
  imports = [
    ./modules/pass.nix
    ./modules/dev.nix
    ../wayland/home.nix
  ];

  home.packages = with pkgs; [ ffmpeg ];
}
