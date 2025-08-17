{ ... }:

{
  imports = [
    ../server/configuration.nix
    ./hardware-configuration.nix

    ./modules/network
    ./modules/users.nix
    ./modules/lxc.nix
  ];

  networking.hostName = "lia";
}
