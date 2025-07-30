{ lib, ... }:
{
  imports = [ ../common/configuration.nix ];

  networking.hostName = lib.mkOptionDefault "server";
  security.sudo.wheelNeedsPassword = false;

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };
}
