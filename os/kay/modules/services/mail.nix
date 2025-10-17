{ config, pkgs, ... }:
let
  ipv6 = "2001:470:ee65::1337";
  domain = config.global.userdata.domain;
  username = config.global.userdata.name;
  email = [
    "${username}@${domain}"

    # used by github automation
    # https://github.com/nocodb/nocodb/blob/32826d4b24e9285b898bb3547fdf550f81c930bb/nix/bumper/bumper.sh#L5
    "auto@${domain}"
    # used by mail.sinanmohd.com
    "postmaster@${domain}"
    # used by ns1.sinanmohd.com
    "hostmaster@${domain}"
  ];

  credentials_directory = "/run/credentials/stalwart-mail.service";
in
{
  security.acme.certs.${domain}.postRun = "systemctl restart stalwart-mail.service";
  sops.secrets = {
    "mail.${domain}/dkim_rsa" = { };
    "mail.${domain}/dkim_ed25519" = { };
    "mail.${domain}/password" = { };
  };

  systemd.services.stalwart-mail.serviceConfig.LoadCredential = [
    "password:${config.sops.secrets."mail.${domain}/password".path}"

    "dkim_rsa:${config.sops.secrets."mail.${domain}/dkim_rsa".path}"
    "dkim_ed25519:${config.sops.secrets."mail.${domain}/dkim_ed25519".path}"

    "cert:${config.security.acme.certs.${domain}.directory}/fullchain.pem"
    "key:${config.security.acme.certs.${domain}.directory}/key.pem"
  ];

  services.postgresql = {
    ensureDatabases = [ "stalwart" ];
    ensureUsers = [
      {
        name = "stalwart";
        ensureDBOwnership = true;
      }
    ];
  };

  services.stalwart-mail = {
    enable = true;
    openFirewall = true;

    settings = {
      queue.outbound = {
        ip-strategy = "ipv6_then_ipv4";
        source-ip.v6 = "['${ipv6}']";
        tls.starttls = "optional";
      };
      http.url = "'https://stalwart.${domain}'";

      server = {
        hostname = "mail.${domain}";
        listener = {
          smtp = {
            bind = [
              "[${ipv6}]:25"
              "0.0.0.0:25"
            ];
            protocol = "smtp";
          };
          submission = {
            bind = "[::]:587";
            protocol = "smtp";
          };
          submissions = {
            bind = "[::]:465";
            protocol = "smtp";
            tls.implicit = true;
          };
          imaptls = {
            bind = "[::]:993";
            protocol = "imap";
            tls.implicit = true;
          };
          http = {
            bind = "[::]:8085";
            protocol = "http";
          };
        };
      };

      signature = {
        rsa = {
          private-key = "%{file:${credentials_directory}/dkim_rsa}%";
          inherit domain;
          selector = "rsa";
          headers = [
            "From"
            "To"
            "Date"
            "Subject"
            "Message-ID"
          ];
          algorithm = "rsa-sha-256";
          canonicalization = "simple/simple";

          set-body-length = true;
          expire = "2d";
          report = true;
        };
        ed25519 = {
          private-key = "%{file:${credentials_directory}/dkim_ed25519}%";
          inherit domain;
          selector = "ed25519";
          headers = [
            "From"
            "To"
            "Date"
            "Subject"
            "Message-ID"
          ];
          algorithm = "ed25519-sha256";
          canonicalization = "simple/simple";

          set-body-length = true;
          expire = "2d";
          report = true;
        };
      };

      certificate."default" = {
        cert = "%{file:${credentials_directory}/cert}%";
        private-key = "%{file:${credentials_directory}/key}%";
      };

      storage = {
        data = "postgresql";
        fts = "postgresql";
        blob = "postgresql";
        lookup = "postgresql";
        directory = "memory";
      };
      store.postgresql = {
        type = "postgresql";
        host = "localhost";
        database = "stalwart";
        user = "stalwart";
        timeout = "15s";
        tls.enable = false;
        pool.max-connections = 10;
      };

      directory."memory" = {
        type = "memory";

        principals = [
          {
            class = "admin";
            name = "${username}@${domain}";
            secret = "%{file:${credentials_directory}/password}%";
            inherit email;
          }
          {
            # for mta-sts & dmarc reports
            class = "individual";
            name = "reports@${domain}";
            secret = "%{file:${credentials_directory}/password}%";
            email = [ "reports@${domain}" ];
          }
        ];
      };
    };
  };
}
