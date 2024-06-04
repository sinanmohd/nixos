{ ... }:

{
  imports = [
    ../common/configuration.nix
    ../server/configuration.nix
    ./hardware-configuration.nix

    ./modules/network
    ./modules/users.nix
    ./modules/lxc.nix
    ./modules/sshfwd.nix
  ];
}

