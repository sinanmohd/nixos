{
  config,
  pkgs,
  lib,
  ...
}:
let
  domain = "headscale.${config.global.userdata.domain}";
  stunPort = 3478;

  # A workaround generate a valid Headscale config accepted by Headplane when `config_strict == true`.
  settings = lib.recursiveUpdate config.services.headscale.settings {
    tls_cert_path = "/dev/null";
    tls_key_path = "/dev/null";
    policy.path = "/dev/null";
  };
  format = pkgs.formats.yaml { };
  headscaleConfig = format.generate "headscale.yml" settings;

  policyFormat = pkgs.formats.json { };
  policy = {
    groups = {
      "group:owner" = [ "sinan@" ];
      "group:bud" = [
        "sinan@"
        "ann@"
      ];
    };
    tagOwners = {
      "tag:bud_clients" = [ "group:bud" ];
      "tag:internal" = [ "group:owner" ];
      "tag:cusat" = [ "group:owner" ];
      "tag:gaijin" = [ "group:owner" ];
    };
    acls = [
      {
        action = "accept";
        src = [ "group:owner" ];
        dst = [ "*:*" ];
      }

      {
        action = "accept";
        src = [ "group:bud" ];
        dst = [ "tag:bud_clients:*" ];
      }
    ];
  };
in
{
  sops.secrets = {
    "headplane/cookie_secret".owner = config.services.headscale.user;
    "headplane/preauth_key".owner = config.services.headscale.user;
    "headscale/noise_private_key".owner = config.services.headscale.user;
    "headscale/derp_private_key".owner = config.services.headscale.user;
  };

  networking.firewall.interfaces.ppp0.allowedUDPPorts = [ stunPort ];

  services = {
    headscale = {
      enable = true;
      port = 8139;

      settings = {
        logtail.enabled = false;
        server_url = "https://${domain}";
        noise.private_key_path = config.sops.secrets."headscale/noise_private_key".path;
        dns = {
          base_domain = "tsnet.${config.global.userdata.domain}";
          override_local_dns = false;
        };
        derp = {
          server = {
            enabled = true;
            private_key_path = config.sops.secrets."headscale/derp_private_key".path;
            region_code = config.networking.hostName;
            region_name = config.networking.hostName;
            stun_listen_addr = "0.0.0.0:${toString stunPort}";
            region_id = 6969;
            automatically_add_embedded_derp_region = true;
          };
          urls = [ ];
        };
        policy = {
          mode = "file";
          path = policyFormat.generate "acl.json" policy;
        };
      };
    };

    headplane = {
      enable = true;
      settings = {
        server = {
          port = 8140;
          cookie_secret_path = config.sops.secrets."headplane/cookie_secret".path;
        };
        headscale = {
          url = "https://${domain}";
          config_path = "${headscaleConfig}";
        };
        integration.agent = {
          enabled = true;
          pre_authkey_path = config.sops.secrets."headplane/preauth_key".path;
        };
      };
    };
  };

  environment.systemPackages = [ config.services.headscale.package ];
}
