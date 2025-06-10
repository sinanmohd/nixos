{ lib, ... }:
{
  imports = [ ../common/configuration.nix ];

  networking.hostName = lib.mkDefault "server";
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };
}
