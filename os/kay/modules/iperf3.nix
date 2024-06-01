{ ... }:

{
  services.iperf3 = {
    enable = true;

    bind = "10.0.0.1";
    openFirewall = true;
  };
}
