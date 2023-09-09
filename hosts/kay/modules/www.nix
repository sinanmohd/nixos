{ config, ... }:

let
  domain = config.userdata.domain;
  email = config.userdata.email;
in
{
  imports = [
    ./dendrite.nix
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
          proxy_read_timeout 600;
        '';
        locations."/_matrix" = {
          proxyPass = "http://127.0.0.1:${toString config.services.dendrite.httpPort}";
        };
        locations."/.well-known/matrix/server".return = ''
          200 '{ "m.server": "${domain}:443" }'
        '';
      };
      "www.${domain}" = {
        forceSSL = true;
        enableACME = true;
        root = "/var/www/${domain}";
      };
    };
  };
}
