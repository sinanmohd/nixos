{ lib, ... }:
{
  imports = [ ../common/configuration.nix ];

  networking.hostName = lib.mkOptionDefault "server";
  security.sudo.wheelNeedsPassword = false;

  programs.mosh.enable = true;
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };
}
