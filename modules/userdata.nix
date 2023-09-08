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
      default = [];
      description = mdDoc "Groups the owner should be in";
    };
    domain = mkOption {
      type = types.str;
      default = "sinanmohd.com";
      description = mdDoc "Owner's domain";
    };
    pubKeys = mkOption {
      type = types.listOf types.str;
      description = mdDoc "Owner's public ssh keys";
      default = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDCeMXhkjm9CabbA/1xdtP9bvFEm8pVXPk66NmI9/VvQ sinan@veu"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL8LnyOuPmtKRqAZeHueNN4kfYvpRQVwCivSTq+SZvDU sinan@cez"
      ];
    };
  };
}
