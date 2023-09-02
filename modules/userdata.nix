{ lib, ... }:

let
  inherit (lib) mkOption types mdDoc;
in
{
  options.userdata =  {
    user = mkOption {
      type = types.str;
      default = "sinan";
      description = mdDoc "owner's username";
    };
    groups = mkOption {
      type = types.listOf types.str;
      description = mdDoc "Groups the owner should be in";
    };
  };
}
