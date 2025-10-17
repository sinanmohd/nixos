{ config, ... }:
let
  keyname = "misc/nixbin.${config.global.userdata.domain}";
in
{
  sops.secrets.${keyname} = { };

  services.nix-serve = {
    enable = true;
    secretKeyFile = config.sops.secrets.${keyname}.path;
  };
}
