{ config, lib, ... }:

let
  inherit (lib) mkOption types;
  cfg = config.userdata;
in
{
  options.userdata =  {
    user = mkOption {
      type = types.str;
      default = "sinan";
      description = "Owner's username";
    };
    userFq = mkOption {
      type = types.str;
      default = "sinanmohd";
      description = "Owner's fully qualified username";
    };
    domain = mkOption {
      type = types.str;
      default = "sinanmohd.com";
      description = "Owner's domain";
    };
    email = mkOption {
      type = types.str;
      default = "${cfg.user}@${cfg.domain}";
      description = "Owner's email";
    };
  };
}
