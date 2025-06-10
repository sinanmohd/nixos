{ pkgs, ... }:
{
  imports = [
    ./modules/pass.nix
    ../wayland/home.nix
  ];

  home.packages = with pkgs; [ ffmpeg ];
}
