{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/network.nix
    ../../common.nix
  ];

  services.openssh.ports = [ 22 465 ];
  networking.hostName = "mox";
}
