{ config, ... }: let
  secret_path = "misc/nocodb-runner-registration-token";
  repo = "nocodb/nocodb";
in {
  sops.secrets.${secret_path} = {};

  services.github-runners.kay = {
    enable = true;
    noDefaultLabels = true;
    extraLabels = [ "nix" ];
    tokenFile = config.sops.secrets.${secret_path}.path;
    url = "https://github.com/${repo}";
  };
}
