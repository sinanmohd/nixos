{ config, ... }:
let
  domain = "grafana." + config.global.userdata.domain;
  user = config.global.userdata.name;
  email = config.global.userdata.email;
in
{
  sops.secrets."misc/default_password" = {
    owner = "grafana";
    group = "grafana";
  };

  services = {
    postgresql = {
      ensureDatabases = [ "grafana" ];
      ensureUsers = [
        {
          name = "grafana";
          ensureDBOwnership = true;
        }
      ];
    };

    grafana = {
      enable = true;

      settings = {
        database = {
          type = "postgres";
          name = "grafana";
          user = "grafana";
          host = "/run/postgresql";
        };

        server = {
          inherit domain;
          enforce_domain = true;
        };

        security = {
          admin_user = user;
          admin_email = email;
          admin_password = "$__file{${config.sops.secrets."misc/default_password".path}}";
        };
      };
    };
  };
}
