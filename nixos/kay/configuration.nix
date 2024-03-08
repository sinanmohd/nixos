{ ... }:

{
  imports = [
    ../common/configuration.nix
    ./hardware-configuration.nix

    ./modules/network.nix
    ./modules/www.nix
    ./modules/sftp.nix
    ./modules/acme.nix
    ./modules/mail.nix
    ./modules/dns
    ./modules/sshfwd.nix
  ];

  boot.consoleLogLevel = 3;
}
