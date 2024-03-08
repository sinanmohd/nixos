{ ... }:

let
  domain = "foss.fscusat.ac.in";
in
{
  services.nginx.virtualHosts.${domain}.locations."/mirror/" = {
    alias = "/var/cache/mirror/";
    extraConfig = "autoindex on;";
  };
}
