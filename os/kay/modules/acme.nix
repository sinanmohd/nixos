{ config, pkgs, ... }: let
  email = config.global.userdata.email;
  domain = config.global.userdata.domain;

  domain_angelo = "angeloantony.com";
  secret_path_angelo = "misc/angelo_cloudflare_dns_api_token";

  environmentFile =
    pkgs.writeText "acme-dns" "RFC2136_NAMESERVER='[2001:470:ee65::1]:53'";
in {
  sops.secrets.${secret_path_angelo} = {};

  security.acme = {
    acceptTerms = true;
    defaults.email = email;

    certs = {
      ${domain_angelo} = {
        domain = domain_angelo;
        extraDomainNames = [ "*.${domain_angelo}" ];

        dnsProvider = "cloudflare";
        credentialFiles.CLOUDFLARE_DNS_API_TOKEN_FILE = config.sops.secrets.${secret_path_angelo}.path;

        group = config.services.nginx.group;
      };

      ${domain} = {
        inherit domain;
        extraDomainNames = [ "*.${domain}" ];

        dnsProvider = "rfc2136";
        dnsPropagationCheck = false; # local DNS server

        inherit environmentFile;
        group = config.services.nginx.group;
      };
    };
  };
}
