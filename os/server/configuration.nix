{ ... }:
{
  imports = [ ../common/configuration.nix ];

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };
}
