{ config, pkgs, lib, ... }:

let
  domain = config.global.userdata.domain;
in
{
  services.nginx = { 
    enable = true;

    recommendedTlsSettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    recommendedProxySettings = true;
    recommendedBrotliSettings = true;

    virtualHosts.${domain} = {
        forceSSL = true;
        enableACME = true;
        useACMEHost = domain;
        locations."= /" = {
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
      };

    };
  };
}
