{ lib, ... }:

let
  inherit (lib) mkOption types mdDoc;
in
{
  options.userdata =  {
    user = mkOption {
      type = types.str;
      default = "sinan";
      description = mdDoc "Owner's username";
    };
    groups = mkOption {
      type = types.listOf types.str;
      description = mdDoc "Groups the owner should be in";
    };
    domain = mkOption {
      type = types.str;
      default = "sinanmohd.com";
      description = mdDoc "Owner's domain";
    };
  };
}
