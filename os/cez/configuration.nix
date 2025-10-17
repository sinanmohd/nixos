{
  imports = [
    ../pc/configuration.nix
    ./hardware-configuration.nix

    ./modules/wireguard.nix
    ./modules/headscale.nix
    ./modules/tlp.nix
    ../../global/cez
  ];

  networking.hostName = "cez";
}
