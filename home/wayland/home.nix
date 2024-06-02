{ ... }: {
  imports = [
    ../common/home.nix
    ./modules/foot.nix
    ./modules/zathura.nix
    ./modules/mako.nix
    ./modules/firefox.nix
    ./modules/mimeapps.nix
  ];
}
