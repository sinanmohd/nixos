{ config, pkgs, lib, ... }:

let
  domain = config.global.userdata.domain;

  domain_angelo = "angeloantony.com";
  ip_angelo = "10.0.1.6";

  storage = "/hdd/users/sftp/shr";
in
{
  imports = [
    ./matrix
    ./cgit.nix
  ];

  security.acme.certs.${domain}.postRun = "systemctl reload nginx.service";
  networking.firewall = {
    allowedTCPPorts = [ 80 443 ];
    allowedUDPPorts = [ 443 ];
  };

  services.prometheus.exporters = {
    nginxlog = {
      enable = true;
      listenAddress = "127.0.0.1";
    };
    nginx = {
      enable = true;
      listenAddress = "127.0.0.1";
    };
  };

  services.nginx = { 
    enable = true;
    statusPage = true;
    package = pkgs.nginxQuic;
    enableQuicBPF = true;

    recommendedTlsSettings = true;
    # breaks home-assistant proxy for some reason
    # only the first request goes through, then site hangs
    # recommendedZstdSettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    recommendedProxySettings = true;
    recommendedBrotliSettings = true;
    eventsConfig = "worker_connections 1024;";

    virtualHosts = let
      defaultOpts = {
        quic = true;
        http3 = true;
        forceSSL = true;
        useACMEHost = domain;
      };
    in {
      "${domain}" = defaultOpts // {
        default = true;
        globalRedirect = "www.${domain}";

        extraConfig = ''
          proxy_buffering off;
          proxy_request_buffering off;
          client_max_body_size 0;
        '';

        locations = {
          "/.well-known/matrix/server".return = ''
            200 '{ "m.server": "${domain}:443" }'
          '';

          "/.well-known/matrix/client".return = ''
            200 '${builtins.toJSON {
                "m.homeserver".base_url = "https://${domain}";
                "org.matrix.msc3575.proxy".url = "https://sliding.${domain}";
                "m.identity_server".base_url = "https://vector.im";
            }}'
          '';

          "~ ^(\\/_matrix|\\/_synapse\\/client)".proxyPass = "http://127.0.0.1:${toString
            config.services.dendrite.httpPort
          }";
        };
      };

      "sliding.${domain}" = defaultOpts // {
        extraConfig = ''
          proxy_buffering off;
          proxy_request_buffering off;
          client_max_body_size 0;
        '';

        locations."/" = {
          proxyWebsockets = true;
          proxyPass =
            "http://${config.services.matrix-sliding-sync-dirty.settings.SYNCV3_BINDADDR}";
        };
      };

      ".${domain_angelo}" = defaultOpts // {
        useACMEHost = domain_angelo;

        extraConfig = ''
          proxy_buffering off;
          proxy_request_buffering off;
          client_max_body_size 0;
        '';

        locations."/" = {
          proxyWebsockets = true;
          proxyPass =
            "http://${ip_angelo}";
        };
      };

      "${config.services.grafana.settings.server.domain}" = defaultOpts // {
        extraConfig = ''
          proxy_buffering off;
          proxy_request_buffering off;
          client_max_body_size 0;
        '';

        locations."/" = {
          proxyWebsockets = true;
          proxyPass =
            "http://${config.services.grafana.settings.server.http_addr}:${builtins.toString config.services.grafana.settings.server.http_port}";
        };
      };

      "www.${domain}" = defaultOpts // {
        root = "/var/www/${domain}";
      };

      "git.${domain}" = defaultOpts;

      "bin.${domain}" = defaultOpts // {
        root = "${storage}/bin";
        locations."= /".return = "307 https://www.${domain}";
      };

      "static.${domain}" = defaultOpts // {
        root = "${storage}/static";
        locations."= /".return = "301 https://www.${domain}";
      };

      "home.${domain}" = defaultOpts // {
        locations."/" = {
          proxyWebsockets = true;
          proxyPass = "http://127.0.0.1:${
            builtins.toString config.services.home-assistant.config.http.server_port
          }";
        };
      };

      "mail.${domain}" = defaultOpts // {
        locations."/" = {
          proxyWebsockets = true;
          proxyPass = "http://127.0.0.1:8085";
        };
      };

      "mta-sts.${domain}" = defaultOpts // {
        locations."= /.well-known/mta-sts.txt".return = ''200 "${
          lib.strings.concatStringsSep "\\n" [
            "version: STSv1"
            "mode: enforce"
            "mx: mail.${domain}"
            "max_age: 86400"
          ]
        }"'';
      };

      "immich.${domain}" = defaultOpts // {
        locations."/" = {
          proxyWebsockets = true;
          proxyPass = "http://${config.services.immich.host}:${builtins.toString config.services.immich.port}";
        };

        extraConfig = ''
          proxy_buffering off;
          proxy_request_buffering off;
          client_max_body_size 0;
        '';
      };

      "nixbin.${domain}" = defaultOpts // {
        extraConfig = ''
          proxy_buffering off;
          proxy_request_buffering off;
          client_max_body_size 0;
        '';

        locations = {
          "= /files".return = "301 https://nixbin.${domain}/files/";
          "/files/" = {
              alias = "/nix/store/";
              extraConfig = "autoindex on;";
          };

          "= /" = {
            extraConfig = "add_header Content-Type text/html;";
            return = ''200
              '<!DOCTYPE html>
              <html lang="en">
                <head>
                  <meta charset="UTF-8">
                  <title>Nix Cache</title>
                </head>
                <body>
                  <center>
                    <h1 style="font-size: 8em">
                      ❄️ Nix Cache
                    </h1>
                    <p style="font-weight: bold">
                      Public Key: nixbin.sinanmohd.com:dXV3KDPVrm+cGJ2M1ZmTeQJqFGaEapqiVoWHgYDh03k=
                    </p>
                  </center>
                </body>
              </html>'
            '';
          };

          "/".proxyPass = "http://${config.services.nix-serve.bindAddress}:${
              toString config.services.nix-serve.port
          }";
        };
      };
    };
  };
}
