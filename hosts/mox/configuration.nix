{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/network.nix
    ../../common.nix
  ];

  services.openssh.ports = [ 22 465 ];
  boot.consoleLogLevel = 3;
  networking.hostName = "mox";
}
