{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/network.nix
    ./modules/www.nix
    ../../common.nix
  ];

  services.openssh.ports = [ 22 465 ];
}
