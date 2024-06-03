{ ... }: {
  imports = [
    ../common/home.nix
    ./modules/foot.nix
    ./modules/zathura.nix
    ./modules/firefox.nix
    ./modules/mimeapps.nix
    ./modules/sway/home.nix
  ];
}
