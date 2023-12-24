{ config, ... }:

let
  domain = config.userdata.domain;
in
{
  sops.secrets."matrix-${domain}/sliding_sync" = {};

  services.matrix-sliding-sync = {
    enable = true;
    environmentFile = config.sops.secrets."matrix-${domain}/sliding_sync".path;
    settings.SYNCV3_SERVER = "http://127.0.0.1:${toString config.services.dendrite.httpPort}";
  };
}
