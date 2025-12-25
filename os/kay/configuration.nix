{ ... }:

{
  imports = [
    ../server/configuration.nix
    ./hardware-configuration.nix

    ./modules/dns
    ./modules/network
    ./modules/observability

    ./modules/internal/www.nix
    ./modules/internal/acme.nix
    ./modules/internal/postgresql.nix

    ./modules/services/sftp.nix
    ./modules/services/mail.nix
    ./modules/services/home-assistant.nix
    ./modules/services/nix-cache.nix
    ./modules/services/immich.nix
    ./modules/services/alina.nix
    ./modules/services/minio.nix
    ./modules/services/matrix
    ./modules/services/cgit.nix
    ./modules/services/nixarr.nix
  ];

  networking.hostName = "kay";
  boot = {
    consoleLogLevel = 3;
    binfmt.emulatedSystems = [ "aarch64-linux" ];
  };
}
