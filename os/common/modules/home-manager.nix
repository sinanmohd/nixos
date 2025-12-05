{ config, lib, ... }:
let
  username = config.global.userdata.name;
  host = config.networking.hostName;
  homeManagerHostPath = ../../../home/${host}/home.nix;
in
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = false;
    users.${username}.imports = [
      ../../../home/common/home.nix
    ]
    ++ lib.optional (builtins.pathExists homeManagerHostPath) homeManagerHostPath;
  };
}
