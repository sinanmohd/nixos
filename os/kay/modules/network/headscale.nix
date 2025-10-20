{
  config,
  pkgs,
  lib,
  headplane,
  namescale,
  ...
}:
let
  url = "https://headscale.${config.global.userdata.domain}";
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
      "tag:namescale" = [ "group:owner" ];
      "tag:internal" = [ "group:owner" ];
      "tag:bud_clients" = [ "group:bud" ];
      "tag:cusat" = [ "group:owner" ];
      "tag:gaijin" = [ "group:owner" ];
    };
    autoApprovers = {
      routes = {
        "192.168.43.0/24" = [
          "group:owner"
          "tag:internal"
        ];
        "192.168.38.0/24" = [
          "group:owner"
          "tag:internal"
        ];
      };
      exitNode = [
        "group:owner"
        "tag:internal"
      ];
    };
    acls = [
      {
        action = "accept";
        src = [ "*" ];
        dst = [ "tag:namescale:${toString config.services.namescale.settings.port}" ];
      }
      {
        action = "accept";
        src = [ "headplane@" ];
        dst = [ "*:*" ];
      }

      {
        action = "accept";
        src = [ "group:owner" ];
        dst = [ "*:*" ];
      }
      {
        action = "accept";
        src = [ "nazer@" ];
        dst = [ "autogroup:internet:*" ];
      }

      {
        action = "accept";
        src = [ "group:bud" ];
        dst = [ "tag:bud_clients:*" ];
      }
      {
        action = "accept";
        src = [ "tag:bud_clients" ];
        dst = [ "tag:bud_clients:80,443" ];
      }
    ];
  };
in
{
  imports = [
    headplane.nixosModules.headplane
    namescale.nixosModules.namescale
  ];

  nixpkgs.overlays = [ headplane.overlays.default ];
  environment.systemPackages = [ config.services.headscale.package ];

  sops.secrets = {
    # server
    "headplane/cookie_secret".owner = config.services.headscale.user;
    "headplane/preauth_key".owner = config.services.headscale.user;
    "headscale/noise_private_key".owner = config.services.headscale.user;
    "headscale/derp_private_key".owner = config.services.headscale.user;
    # client
    "headscale/pre_auth_key" = { };
  };

  networking = {
    nameservers = [ "100.100.100.100" ];
    search = [ config.services.headscale.settings.dns.base_domain ];

    firewall = {
      interfaces.ppp0.allowedUDPPorts = [ stunPort ];
      trustedInterfaces = [ config.services.tailscale.interfaceName ];
    };
  };
  # for exit node only
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = true;
    "net.ipv6.conf.all.forwarding" = true;
  };

  services = {
    headscale = {
      enable = true;
      port = 8139;

      settings = {
        logtail.enabled = false;
        server_url = url;
        noise.private_key_path = config.sops.secrets."headscale/noise_private_key".path;
        dns = {
          base_domain = "tsnet.${config.global.userdata.domain}";
          override_local_dns = false;
          nameservers.split."${config.services.headscale.settings.dns.base_domain}" = [
            config.services.namescale.settings.host
          ];
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
          inherit url;
          config_path = "${headscaleConfig}";
        };
        integration.agent = {
          enabled = true;
          pre_authkey_path = config.sops.secrets."headplane/preauth_key".path;
        };
      };
    };

    tailscale = {
      enable = true;
      interfaceName = "headscale";
      openFirewall = true;

      authKeyFile = config.sops.secrets."headscale/pre_auth_key".path;
      extraUpFlags = [
        "--login-server=${url}"
        "--advertise-exit-node"
        "--advertise-routes=192.168.43.0/24,192.168.38.0/24"
        "--advertise-tags=tag:internal,tag:namescale"
      ];
    };

    namescale = {
      enable = true;
      settings = {
        host = "100.64.0.6";
        port = 53;
        base_domain = config.services.headscale.settings.dns.base_domain;
      };
    };
  };
}
