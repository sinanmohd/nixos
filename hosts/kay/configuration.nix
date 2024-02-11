{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/network.nix
    ./modules/www.nix
    ./modules/sftp.nix
    ./modules/acme.nix
    ./modules/dns
    ./modules/sshfwd.nix
    ../../common.nix
  ];

  boot.consoleLogLevel = 3;
}
