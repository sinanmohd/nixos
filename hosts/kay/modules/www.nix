{ config, ... }:

let
  domain = config.userdata.domain;
  email = config.userdata.email;
  fscusat = "fscusat.org";
  mark = "themark.ing";
in
{
  imports = [
    ./dendrite.nix
    ./matrix_sliding_sync.nix
    ./cgit.nix
  ];

  networking.firewall.allowedTCPPorts = [ 80 443 ];
  security.acme = {
    acceptTerms = true;
    defaults.email = email;
  };

  services.nginx = { 
    enable = true;
    virtualHosts = {
      "${domain}" = {
        forceSSL = true;
        enableACME = true;
        globalRedirect = "www.${domain}";

        extraConfig = ''
          client_max_body_size ${toString config.services.dendrite.settings.media_api.max_file_size_bytes};
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $remote_addr;
          proxy_set_header X-Forwarded-Proto $scheme;
        '';

        locations."/.well-known/matrix/server".return = ''
          200 '{ "m.server": "${domain}:443" }'
        '';
        locations."/_matrix" = {
          proxyPass = "http://127.0.0.1:${toString config.services.dendrite.httpPort}";
        };

        locations."/.well-known/matrix/client".return = ''
          200 '${builtins.toJSON {
              "m.homeserver".base_url = "https://${domain}";
              "org.matrix.msc3575.proxy".url = "https://${domain}";
          }}'
        '';
        locations."/_matrix/client/unstable/org.matrix.msc3575/sync" = let
          addr = "${config.services.matrix-synapse.sliding-sync.settings.SYNCV3_BINDADDR}";
        in {
          proxyPass = "http://${addr}";
        };
      };
      "www.${domain}" = {
        forceSSL = true;
        enableACME = true;
        root = "/var/www/${domain}";
      };
      "${fscusat}" = {
        forceSSL = true;
        enableACME = true;
        globalRedirect = "www.${fscusat}";
      };
      "www.${fscusat}" = {
        forceSSL = true;
        enableACME = true;
        extraConfig = ''
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_read_timeout 600;
        '';

        locations."/" = {
          return = "200 '<h1>under construction</h1>'";
          extraConfig = "add_header Content-Type text/html;";
        };
      };
      "${mark}" = {
        forceSSL = true;
        enableACME = true;
        globalRedirect = "www.${mark}";
      };
      "www.${mark}" = {
        forceSSL = true;
        enableACME = true;

        locations."/" = {
          return = "200 '<h1>under construction, see you soon</h1>'";
          extraConfig = "add_header Content-Type text/html;";
        };
      };
    };
  };
}
