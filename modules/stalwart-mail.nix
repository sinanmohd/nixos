{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.stalwart-mail;
  configFormat = pkgs.formats.toml { };
  configFile = configFormat.generate "stalwart-mail.toml" cfg.settings;
  dataDir = "/var/lib/stalwart-mail";

  readTOML =
    path:
    builtins.fromTOML (builtins.unsafeDiscardStringContext (lib.readFile path));
  recursiveUpdateList =
    attrList:
    lib.lists.foldr (a1: a2: lib.attrsets.recursiveUpdate a1 a2) {} attrList;
  mkOverrideRec =
    priority:
    content:
    if lib.isAttrs content then
      lib.mapAttrs (_: v: mkOverrideRec priority v) content
    else
      lib.mkOverride priority content;
  mkOptionDefaultRec = mkOverrideRec 1500;

  cfgPkg = pkgs.callPackage ../pkgs/stalwart-mail-config.nix {};
  cfgFiles = (readTOML "${cfgPkg}/config.toml").include.files;
  settingsDefault = recursiveUpdateList (map (path: readTOML path) cfgFiles);
in {
  options.services.stalwart-mail = {
    enable = mkEnableOption (mdDoc "the Stalwart all-in-one email server");
    package = mkPackageOption pkgs "stalwart-mail" { };

    loadCredential = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      example = [ "dkim.private:/path/to/stalwart.private" ];
      description = lib.mdDoc ''
        This can be used to pass secrets to the systemd service without adding them to
        the nix store.
        See the LoadCredential section of systemd.exec manual for more information.
      '';
    };

    settings = mkOption {
      inherit (configFormat) type;
      default = { };
      description = mdDoc ''
        Configuration options for the Stalwart email server.
        See <https://stalw.art/docs/category/configuration> for available options.

        By default, the module is configured to store everything locally.
      '';
    };
  };

  config = mkIf cfg.enable {
    # set the default upstream settings
    # assumptions
    # 1. ./config.toml exists and only containts include.files and macros
    # 2. no other files containts include.files
    services.stalwart-mail.settings = mkOptionDefaultRec
      (lib.attrsets.recursiveUpdate settingsDefault {
        macros.base_path = dataDir;
        server.run-as.user = {};
        server.run-as.group = {};
        global.tracing.method = "stdout";
        # outliers as of v0.6.0
        acme."letsencrypt".cache = "${cfg.settings.macros.base_path}/acme";
      });

    assertions = let 
      m = cfg.settings.macros;

      mkMacroMessage =
        opt:
        "config.stalwart-mail.settings.macros.${opt} can not be empty";
    in [
      {
        assertion = m ? host
                    && m.host != ""
                    && m.host != null;
        message = mkMacroMessage "host";
      }
      {
        assertion = m ? default_domain
                    && m.default_domain != ""
                    && m.default_domain != null;
        message = mkMacroMessage "default_domain";
      }
      {
        assertion = m ? default_directory
                    && m.default_directory != ""
                    && m.default_directory != null;
        message = mkMacroMessage "default_directory";
      }
      {
        assertion = m ? default_store &&
                    m.default_store != ""
                    && m.default_store != null;
        message = mkMacroMessage "default_store";
      }
    ];

    systemd.services.stalwart-mail = {
      wantedBy = [ "multi-user.target" ];
      after = [ "local-fs.target" "network.target" ];

      serviceConfig = {
        ExecStart =
          "${cfg.package}/bin/stalwart-mail --config=${configFile}";

        # Base from template resources/systemd/stalwart-mail.service
        Type = "simple";
        LimitNOFILE = 65536;
        KillMode = "process";
        KillSignal = "SIGINT";
        Restart = "on-failure";
        RestartSec = 5;
        StandardOutput = "journal";
        StandardError = "journal";
        SyslogIdentifier = "stalwart-mail";

        DynamicUser = true;
        User = "stalwart-mail";
        StateDirectory = "stalwart-mail";
        LoadCredential = cfg.loadCredential;

        # Bind standard privileged ports
        AmbientCapabilities = [ "CAP_NET_BIND_SERVICE" ];
        CapabilityBoundingSet = [ "CAP_NET_BIND_SERVICE" ];

        # Hardening
        DeviceAllow = [ "" ];
        LockPersonality = true;
        MemoryDenyWriteExecute = true;
        PrivateDevices = true;
        PrivateUsers = false;  # incompatible with CAP_NET_BIND_SERVICE
        ProcSubset = "pid";
        PrivateTmp = true;
        ProtectClock = true;
        ProtectControlGroups = true;
        ProtectHome = true;
        ProtectHostname = true;
        ProtectKernelLogs = true;
        ProtectKernelModules = true;
        ProtectKernelTunables = true;
        ProtectProc = "invisible";
        ProtectSystem = "strict";
        RestrictAddressFamilies = [ "AF_INET" "AF_INET6" ];
        RestrictNamespaces = true;
        RestrictRealtime = true;
        RestrictSUIDSGID = true;
        SystemCallArchitectures = "native";
        SystemCallFilter = [ "@system-service" "~@privileged" ];
        UMask = "0077";
      };
    };

    # Make admin commands available in the shell
    environment.systemPackages = [ cfg.package ];
  };

  meta = {
    maintainers = with maintainers; [ happysalada pacien ];
  };
}
