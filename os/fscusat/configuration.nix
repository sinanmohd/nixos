{ ... }:

{
  imports = [
    ../common/configuration.nix
    ../server/configuration.nix
    ./hardware-configuration.nix

    ./modules/network.nix
    ./modules/www.nix
    ./modules/mirror
  ];

  services.openssh.ports = [ 22 465 ];
}
