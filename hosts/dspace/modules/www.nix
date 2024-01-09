{ config, ... }:

let
  domain = "dsp.fscusat.ac.in";
in
{
  networking.firewall.allowedTCPPorts = [ 80 443 ];

  sops.secrets = let 
    opts = {
      owner = config.services.nginx.user;
      group = config.services.nginx.group;
    };
  in{
    "cusat.ac.in/key" = opts;
    "cusat.ac.in/crt" = opts;
  };

  services.nginx = { 
    enable = true;
    recommendedTlsSettings = true;
    recommendedZstdSettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    recommendedProxySettings = true;
    recommendedBrotliSettings = true;

    virtualHosts.${domain} = {
      forceSSL = true;
      sslCertificateKey = config.sops.secrets."cusat.ac.in/key".path;
      sslCertificate = config.sops.secrets."cusat.ac.in/crt".path;

      locations."/" = {
        return = "200 '<h1>under construction</h1>'";
        extraConfig = "add_header Content-Type text/html;";
      };
    };
  };
}
