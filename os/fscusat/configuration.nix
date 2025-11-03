{ ... }:

{
  imports = [
    ../server/configuration.nix
    ./hardware-configuration.nix

    ./modules/network/lan.nix
    ./modules/network/headscale.nix
    ./modules/www.nix
    ./modules/mirror
  ];

  networking.hostName = "fscusat";
  services.openssh.ports = [
    22
    465
  ];
}
