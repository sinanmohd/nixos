{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../common.nix
    ./modules/network
    ./modules/users.nix
    ./modules/lxc.nix
    ./modules/sshfwd.nix
  ];
}

