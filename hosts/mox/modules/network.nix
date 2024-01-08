{ ... }:

let
  wan = "ens18";
  dns = "10.0.0.2";
in
{
  networking = {
    interfaces.${wan}.ipv4.addresses = [{
      address = "10.0.8.101";
      prefixLength = 16;
    }];
    defaultGateway = {
      address = "10.0.0.1";
      interface = wan;
    };
  };

  services = {
    dnsmasq = {
      enable = true;
      settings.server = [ dns ];
    };
  };
}
