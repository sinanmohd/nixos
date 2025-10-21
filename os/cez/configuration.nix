{
  imports = [
    ../pc/configuration.nix
    ./hardware-configuration.nix

    ./modules/headscale.nix
    ./modules/wireguard.nix
    ./modules/tlp.nix
    ../../global/cez
  ];

  networking.hostName = "cez";
}
