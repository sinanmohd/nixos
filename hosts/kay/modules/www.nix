{ config, pkgs, ... }:

let
  domain = config.userdata.domain;
  fscusat = "fscusat.org";
  mark = "themark.ing";
  storage = "/hdd/users/sftp/shr";
in
{
  imports = [
    ./dendrite.nix
    ./matrix-sliding-sync.nix
    ./cgit.nix
  ];

  networking.firewall = {
    allowedTCPPorts = [ 80 443 ];
    allowedUDPPorts = [ 443 ];
  };

  services.nginx = { 
    enable = true;
    package = pkgs.nginxQuic;
    enableQuicBPF = true;

    recommendedTlsSettings = true;
    recommendedZstdSettings = true;
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
            "http://${config.services.matrix-sliding-sync.settings.SYNCV3_BINDADDR}";
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

      "${fscusat}" = defaultOpts // {
        useACMEHost = null;
        enableACME = true;

        globalRedirect = "www.${fscusat}";
      };
      "www.${fscusat}" = defaultOpts // {
        useACMEHost = null;
        enableACME = true;

        locations."/" = {
          return = "200 '<h1>under construction</h1>'";
          extraConfig = "add_header Content-Type text/html;";
        };
      };

      "${mark}" = defaultOpts // {
        useACMEHost = null;
        enableACME = true;

        globalRedirect = "www.${mark}";
      };
      "www.${mark}" = defaultOpts // {
        useACMEHost = null;
        enableACME = true;

        locations."/" = {
          return = "200 '<h1>under construction, see you soon</h1>'";
          extraConfig = "add_header Content-Type text/html;";
        };
      };
    };
  };
}
