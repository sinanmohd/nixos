{ config, ... }: let
  ipv6 = "2001:470:ee65::1337";
  domain = config.userdata.domain;

  username = config.userdata.name;
  secret = "$argon2i$v=19$m=4096,t=3,p=1$SWV5aWU3YWUgZWFTNm9oc28gTGFvdDdlRG8ga2FTaWVjaDYgYWV0aDFHb28$O/sDv7oy9wUxFjvKoxB5o8ZnPvjYJo9DjX0C/AZQFF0";
  email = [
    "${username}@${domain}"
    "sinanmohd@${domain}"
    "me@${domain}"

    "postmaster@${domain}"
    "hostmaster@${domain}"
    "admin@${domain}"
  ];

  credentials_directory = "/run/credentials/stalwart-mail.service";
in {
  networking.firewall.allowedTCPPorts = [
    25    # smto
    465   # submission
    587   # submissions
    993   # imap ssl
    4190  # managesieve
  ];

  security.acme.certs.${domain}.postRun = "systemctl restart stalwart-mail.service";
  sops.secrets = {
    "mail.${domain}/dkim_rsa" = {};
    "mail.${domain}/dkim_ed25519" = {};
  };

  services.stalwart-mail = {
    enable = true;
    loadCredential = [
      "dkim_rsa:${config.sops.secrets."mail.${domain}/dkim_rsa".path}"
      "dkim_ed25519:${config.sops.secrets."mail.${domain}/dkim_ed25519".path}"

      "cert:${config.security.acme.certs.${domain}.directory}/fullchain.pem"
      "key:${config.security.acme.certs.${domain}.directory}/key.pem"
    ];

    settings = {
      macros = {
        host = "mail.${domain}";
        default_domain = domain;
        default_directory = "in-memory";
        default_store = "sqlite";
      };

      queue.outbound = {
        ip-strategy = "ipv6_then_ipv4";
        source-ip.v6 = "['${ipv6}']";
        tls.starttls = "optional";
      };
      server.listener = {
        smtp.bind = [ "[${ipv6}]:25" "0.0.0.0:25" ];
        jmap.bind = [ "[::]:8034" ];
      };

      signature = {
        rsa = {
          private-key = "file://${credentials_directory}/dkim_rsa";
          selector = "rsa";
          set-body-length = true;
        };
        ed25519 = {
          public-key = "EHk924AruF9Y0Xaf009rpRl+yGusjmjT1Zeho67BnDU=";
          private-key = "file://${credentials_directory}/dkim_ed25519";
          domain = "%{DEFAULT_DOMAIN}%";
          selector = "ed25519";
          headers = [ "From" "To" "Date" "Subject" "Message-ID" ];
          algorithm = "ed25519-sha256";
          canonicalization = "relaxed/relaxed";
          set-body-length = true;
          report = true;
        };
      };

      certificate."default" = {
        cert = "file://${credentials_directory}/cert";
        private-key = "file://${credentials_directory}/key";
      };

      storage.blob = "fs";
      store = {
        fs.disable = false;
        sqlite.disable = false;
      };

      directory."in-memory" = {
        type = "memory";
        options.subaddressing = true;

        principals = [
          {
            inherit email;
            inherit secret;
            name = username;
            type = "admin";
          }
          { # for mta-sts & dmarc reports
            email = "reports${domain}";
            inherit secret;
            name = "reports";
            type = "individual";
          }
        ];
      };
    };
  };
}
