{ nixarr, ... }:
let
  mediaDir = "/hdd/nixarr";
  stateDir = "${mediaDir}/.state/nixarr";
in
{
  imports = [ nixarr.nixosModules.default ];

  nixarr = {
    enable = true;
    inherit mediaDir stateDir;

    transmission = {
      enable = true;
      peerPort = 50000;
      extraAllowedIps = [ "100.64.0.*" ];
    };

    jellyfin.enable = true;
    bazarr.enable = true;
    lidarr.enable = true;
    prowlarr.enable = true;
    radarr.enable = true;
    readarr.enable = true;
    sonarr.enable = true;
    jellyseerr.enable = true;
  };
}
