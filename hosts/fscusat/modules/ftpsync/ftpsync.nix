{ config, lib, pkgs, ... }:

let
  cfg = config.services.ftpsync;
  archvsync = pkgs.callPackage ../../pkgs/archvsync {};

  formatKeyValue = k: v: '' ${k}="${v}" '';
  configFormat = pkgs.formats.keyValue { mkKeyValue = formatKeyValue; };
  configFile = configFormat.generate "ftpsync.conf" cfg.settings;
in
{
  meta.maintainers = with lib.maintainers; [ sinanmohd ];

  options.services.ftpsync = {
    enable = lib.mkEnableOption (lib.mdDoc "ftpsync");

    settings = lib.mkOption {
      inherit (configFormat) type;
      default = {};
      description = lib.mdDoc ''
        Configuration options for ftpsync.
        See ftpsync.conf(5) man page for available options.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    environment.etc."ftpsync/ftpsync.conf".source = configFile;
    environment.systemPackages = [ archvsync ];

    services.ftpsync.settings = {
      TO = lib.mkDefault "$STATE_DIRECTORY";
      LOGDIR = lib.mkDefault "$LOGS_DIRECTORY";
    };

    systemd = let
      name = "ftpsync";
      meta = {
        description = "Mirror Debian repositories of packages";
        documentation = [ "man:ftpsync(1)" ];
      };
    in {
      timers.${name} = meta // {
        wantedBy = [ "timers.target" ];

        timerConfig = {
          OnCalendar = "*-*-* 00,06,12,18:00:00";
          Unit="%i.service";
          Persistent = true;
          FixedRandomDelay = true;
          RandomizedDelaySec = "6h";
        };
      };

      services.${name} = meta // {
        serviceConfig = {
          DynamicUser = true;
          LogsDirectory = name;
          StateDirectory = name;

          ExecStart = "${archvsync}/bin/ftpsync sync:all";
        };
      };
    };
  };
}
