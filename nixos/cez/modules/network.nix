{ ... }:

{
  networking = {
    firewall.enable = false;

    wireless.iwd = { 
      enable = true;
      settings = {
        General.EnableNetworkConfiguration = true;
        Network.NameResolvingService = "resolvconf";
      };
    };
  };
}
