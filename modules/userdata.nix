{ config, lib, pkgs, ... }:

let
  inherit (lib) mkOption types mdDoc;
  cfg = config.userdata;

  defaultPackages = with pkgs; [
    dig
    mtr
    nnn
    ps_mem
    brightnessctl
  ];
  defaultPubKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDCeMXhkjm9CabbA/1xdtP9bvFEm8pVXPk66NmI9/VvQ sinan@vex"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL8LnyOuPmtKRqAZeHueNN4kfYvpRQVwCivSTq+SZvDU sinan@cez"
  ];
  defaultGroups = [ "wheel" ];
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
    email = mkOption {
      type = types.str;
      default = "sinan@firemail.cc";
      description = mdDoc "Owner's email";
    };
    packages = mkOption {
      type = types.listOf types.package;
      default = [];
      description = mdDoc "Packages in owner's environment";
    };
    pubKeys = mkOption {
      type = types.listOf types.str;
      description = mdDoc "Owner's public ssh keys";
      default = [];
    };
  };

  config.users.users.${cfg.user} = {
    uid = 1000;
    isNormalUser = true;
    description = cfg.email;

    extraGroups = defaultGroups ++ cfg.groups;
    packages = defaultPackages ++ cfg.packages;
    openssh.authorizedKeys.keys = defaultPubKeys ++ cfg.pubKeys;
  };
}
