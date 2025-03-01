{ config, ... }:
let
  repo = "nocodb/nocodb";
in
{
  sops.secrets = {
    "github-runner/nocodb-registration-token" = { };
    "github-runner/age-master-key" = { };
  };

  services.github-runners.kay = {
    enable = true;
    noDefaultLabels = true;
    extraLabels = [ "nix" ];
    tokenFile = config.sops.secrets."github-runner/nocodb-registration-token".path;
    url = "https://github.com/${repo}";
  };

  systemd.services."github-runner-kay" = {
    environment.SOPS_AGE_KEY_FILE = "%d/age-master-key";
    serviceConfig.LoadCredential =
      "age-master-key:${config.sops.secrets."github-runner/age-master-key".path}"; 
  };
}
