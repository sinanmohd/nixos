{ pkgs, ... }:
{
  imports = [
    ./modules/pass.nix
    ./modules/k9s.nix
    ../wayland/home.nix
  ];

  home.packages = with pkgs; [
    ffmpeg
    mosh
  ];
}
