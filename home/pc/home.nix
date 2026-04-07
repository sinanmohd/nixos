{ pkgs, ... }:
{
  imports = [
    ./modules/vaultwarden.nix
    ./modules/k8s
    ../wayland/home.nix
  ];

  home.packages = with pkgs; [
    ffmpeg
    mosh
  ];
}
