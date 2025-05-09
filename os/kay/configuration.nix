{ ... }:

{
  imports = [
    ../common/configuration.nix
    ../server/configuration.nix
    ./hardware-configuration.nix

    ./modules/network.nix
    ./modules/www.nix
    ./modules/sftp.nix
    ./modules/acme.nix
    ./modules/mail.nix
    ./modules/dns
    ./modules/sshfwd.nix
    ./modules/home-assistant.nix
    ./modules/postgresql.nix
    ./modules/github-runner.nix
    ./modules/nix-cache.nix
    ./modules/immich.nix
    ./modules/observability
    ./modules/alina.nix
  ];

  boot = {
    consoleLogLevel = 3;
    binfmt.emulatedSystems = [ "aarch64-linux" ];
  };
}
