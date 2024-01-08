{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/network.nix
    ./modules/www.nix
    ./modules/sftp.nix
    ../../common.nix
  ];

  boot.consoleLogLevel = 3;
  networking.hostName = "kay";
}
