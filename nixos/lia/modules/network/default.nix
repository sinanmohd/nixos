{ ... }: let
  wan = "enp9s0";
in
{
  imports = [
    ./router.nix
  ];

  networking = {
    interfaces.${wan}.ipv4.addresses = [{
      address = "172.16.148.20";
      prefixLength = 22;
    }];
    defaultGateway = {
      address = "172.16.148.1";
      interface = wan;
    };
  };
}
