{ config, ... }: let
  listen_addr = "2001:470:ee65::1";
in {
  imports = [ ./ddns.nix ];

  networking.firewall = {
    allowedTCPPorts = [ 53 ];
    allowedUDPPorts = [ 53 ];
  };

  sops.secrets.dns = {
    owner = config.systemd.services.knot.serviceConfig.User;
    group = config.systemd.services.knot.serviceConfig.Group;
  };

  services.knot = {
    enable = true;
    keyFiles = [ config.sops.secrets.dns.path ];

    settings = {
      server.listen = listen_addr;

      remote = [{
        id = "ns1.he.net";
        address = [ "2001:470:100::2" "216.218.130.2" ];
        via = "2001:470:ee65::1";
      }];

      # generate TSIG key with keymgr -t name
      acl = [
        {
          id = "ns1.he.net";
          key = "ns1.he.net";
          address = [ "2001:470:600::2" "216.218.133.2" ];
          action = "transfer";
        }
        {
          id = "localhost";
          address = [ listen_addr ];
          update-type = [ "A" "AAAA" ];
          action = "update";
        }
      ];

      mod-rrl = [{
        id = "default";
        rate-limit = 200;
        slip = 2;
      }];

      template = [
        {
          id = "default";
          semantic-checks = "on";
          global-module = "mod-rrl/default";
        }
        {
          id = "master";
          semantic-checks = "on";
          notify = [ "ns1.he.net" ];
          acl = [ "ns1.he.net" "localhost" ];
          zonefile-sync = "-1";
          zonefile-load = "difference";
        }
      ];

      zone = [{
        domain = "sinanmohd.com";
        file = ./sinanmohd.com.zone;
        template = "master";
      }];
    };
  };

}
