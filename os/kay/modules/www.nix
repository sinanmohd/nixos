{ config, pkgs, lib, ... }:

let
  domain = config.global.userdata.domain;
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

  services.nginx = { 
    enable = true;
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
          client_max_body_size ${toString
            config.services.dendrite.settings.media_api.max_file_size_bytes
          };
        '';

        locations = {
          "/.well-known/matrix/server".return = ''
            200 '{ "m.server": "${domain}:443" }'
          '';

          "/.well-known/matrix/client".return = ''
            200 '${builtins.toJSON {
                "m.homeserver".base_url = "https://${domain}";
                "org.matrix.msc3575.proxy".url = "https://${domain}";
            }}'
          '';

          "/_matrix".proxyPass = "http://127.0.0.1:${toString
            config.services.dendrite.httpPort
          }";

          "/_matrix/client/unstable/org.matrix.msc3575/sync".proxyPass =
            "http://${config.services.matrix-sliding-sync-dirty.settings.SYNCV3_BINDADDR}";
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
        extraConfig = "proxy_buffering off;";
        locations."/" = {
          proxyWebsockets = true;
          proxyPass = "http://127.0.0.1:${
            builtins.toString config.services.home-assistant.config.http.server_port
          }";
        };
      };

      "mail.${domain}" = defaultOpts // {
        extraConfig = "proxy_buffering off;";
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
    };
  };
}
