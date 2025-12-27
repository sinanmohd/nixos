{ ... }:
{
  imports = [
    ../server/configuration.nix
    ./hardware-configuration.nix

    ./modules/dns
    ./modules/network/ppp
    ./modules/network/headscale
    ./modules/network/hurricane
    ./modules/network/router.nix

    ./modules/observability

    ./modules/internal/www.nix
    ./modules/internal/acme.nix
    ./modules/internal/postgresql.nix
    ./modules/internal/k3s

    ./modules/services/sftp.nix
    ./modules/services/mail
    ./modules/services/home-assistant.nix
    ./modules/services/nix-cache
    ./modules/services/immich.nix
    ./modules/services/alina
    ./modules/services/minio.nix
    ./modules/services/matrix
    ./modules/services/cgit.nix
    ./modules/services/nixarr.nix
    ./modules/services/vaultwarden
  ];

  networking.hostName = "kay";

  boot = {
    consoleLogLevel = 3;
    binfmt.emulatedSystems = [ "aarch64-linux" ];
  };
}
