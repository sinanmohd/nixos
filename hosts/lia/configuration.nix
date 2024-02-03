{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../common.nix
    ./modules/network
    ./modules/users.nix
  ];
}

