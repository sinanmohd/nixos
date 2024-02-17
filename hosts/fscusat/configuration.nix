{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/network.nix
    ./modules/www.nix
    ./modules/ftpsync
    ../../common.nix
  ];

  services.openssh.ports = [ 22 465 ];
}
