{ lib, ... }:
{
  imports = [ ../common/configuration.nix ];

  networking.hostName = lib.mkOptionDefault "server";
  security.sudo.wheelNeedsPassword = false;
}
