{ config, ... }: let
  ipv6 = "2001:470:ee65::1337";
  domain = config.global.userdata.domain;
  username = config.global.userdata.name;
  email = [
    "${username}@${domain}"
    "official@${domain}"

    "postmaster@${domain}"
    "hostmaster@${domain}"
  ];

  credentials_directory = "/run/credentials/stalwart-mail.service";
in {
  security.acme.certs.${domain}.postRun = "systemctl restart stalwart-mail.service";
  sops.secrets = {
    "mail.${domain}/dkim_rsa" = {};
    "mail.${domain}/dkim_ed25519" = {};
    "mail.${domain}/password" = {};
  };

  systemd.services.stalwart-mail.serviceConfig.loadCredential = [
    "password:${config.sops.secrets."mail.${domain}/password".path}"

    "dkim_rsa:${config.sops.secrets."mail.${domain}/dkim_rsa".path}"
    "dkim_ed25519:${config.sops.secrets."mail.${domain}/dkim_ed25519".path}"

    "cert:${config.security.acme.certs.${domain}.directory}/fullchain.pem"
    "key:${config.security.acme.certs.${domain}.directory}/key.pem"
  ];

  services.stalwart-mail = {
    enable = false;
    openFirewall = true;

    settings = {
      queue.outbound = {
        ip-strategy = "ipv6_then_ipv4";
        source-ip.v6 = "['${ipv6}']";
        tls.starttls = "optional";
      };

      server.listener = {
        smtp = {
          bind = [ "[${ipv6}]:25" "0.0.0.0:25" ];
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
        };
        http = {
          bind = "[::]:8085";
          protocol = "http";
        };
      };

      signature = {
        rsa = {
          private-key = "%{file:/${credentials_directory}/dkim_rsa}%";
          inherit domain;
          selector = "rsa";
          headers = ["From" "To" "Date" "Subject" "Message-ID"];
          algorithm = "rsa-sha-256";
          canonicalization = "relaxed/relaxed"; # what

          expire = "10d";
          report = true;
        };
        ed25519 = {
          private-key = "%{file:/${credentials_directory}/dkim_ed25519}%";
          inherit domain;
          selector = "ed25519";
          headers = ["From" "To" "Date" "Subject" "Message-ID"];
          algorithm = "ed25519-sha256";
          canonicalization = "relaxed/relaxed"; # what

          expire = "10d";
          report = true;
        };
      };

      certificate."default" = {
        cert = "%{file:/${credentials_directory}/cert}%";
        private-key = "%{file:/${credentials_directory}/key}%";
      };

      storage = {
        data = "rocksdb";
        fts = "rocksdb";
        blob = "rocksdb";
        lookup = "rocksdb";
        directory = "in-memory";
      };
      store.rocksdb = {
        type = "rocksdb";
        path = "rocksdb";
        compression = "lz4";
      };

      directory."in-memory" = {
        type = "memory";
        options.subaddressing = true;

        principals = [
          {
            inherit email;
            secret = "%{file:/${credentials_directory}/password}%";
            name = username;
            type = "admin";
          }
          { # for mta-sts & dmarc reports
            email = "reports${domain}";
            secret = "%{file:/${credentials_directory}/password}%";
            name = "reports";
            type = "individual";
          }
        ];
      };
    };
  };
}
