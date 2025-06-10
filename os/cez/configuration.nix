{ ... }:
{
  imports = [
    ../pc/configuration.nix
    ./hardware-configuration.nix

    ./modules/specialisation.nix
    ./modules/wireguard.nix
    ./modules/tlp.nix
  ];
}
