{ pkgs, ... }: {
  imports = [
    ../common/home.nix
    ./modules/foot.nix
    ./modules/zathura.nix
    ./modules/firefox.nix
    ./modules/mimeapps.nix
    ./modules/sway/home.nix
  ];

  home.packages = with pkgs; [
    wtype
    grim
    slurp
    xdg-utils

    mpv
    imv
    qemu
    element-desktop-wayland
  ];
}
