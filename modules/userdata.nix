{ config, lib, ... }:

let
  inherit (lib) mkOption types mdDoc;
  cfg = config.userdata;
in
{
  options.userdata =  {
    user = mkOption {
      type = types.str;
      default = "sinan";
      description = mdDoc "Owner's username";
    };
    domain = mkOption {
      type = types.str;
      default = "sinanmohd.com";
      description = mdDoc "Owner's domain";
    };
    email = mkOption {
      type = types.str;
      default = "sinan@firemail.cc";
      description = mdDoc "Owner's email";
    };
  };

  config.users.users.${cfg.user} = {
    uid = 1000;
    isNormalUser = true;
    description = cfg.email;
  };
}
