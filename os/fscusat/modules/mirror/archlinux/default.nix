{ pkgs, ... }:

let
  interval = "6h";
in
{
  systemd.services.archSyncService = {
    description = "Run my script every 6 hours";

    serviceConfig = {
      ExecStart = "${pkgs.bash}/bin/bash ${./sync-repo.sh}";
    };

    wantedBy = [ "multi-user.target" ];
  };

  systemd.timers.archSyncTimer = {
    description = "Timer to run my script every 6 hours";

    timerConfig = {
      OnUnitActiveSec = interval;
      Unit = "archSyncService.service";
    };

    wantedBy = [ "timers.target" ];
  };
}
