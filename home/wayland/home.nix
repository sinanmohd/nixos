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
    mpv
    imv
    wtype
    qemu
    grim
    slurp
    xdg-utils
    element-desktop-wayland
  ];
}
