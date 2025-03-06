{ config, ... }:
let
  repo = "nocodb/nocodb";
  nocodbRunnerUser = "nocodbrunner";
  user = config.global.userdata.name;
in
{
  sops.secrets = {
    "github-runner/nocodb-registration-token" = { };
    "github-runner/age-master-key" = { };
  };

  # required by github:nocodb/nocodb docker builds
  virtualisation.docker.enable = true;
  users.groups.${nocodbRunnerUser} = { };
  users.extraGroups.docker.members = [
    user
    nocodbRunnerUser
  ];
  users.users.nocodbrunner = {
    name = nocodbRunnerUser;
    group = nocodbRunnerUser;
    isSystemUser = true;
  };
  services.github-runners.kay = {
    user = nocodbRunnerUser;
    group = nocodbRunnerUser;
    enable = true;
    noDefaultLabels = true;
    extraLabels = [ "nix" ];
    tokenFile = config.sops.secrets."github-runner/nocodb-registration-token".path;
    url = "https://github.com/${repo}";
  };

  systemd.services."github-runner-kay" = {
    environment.SOPS_AGE_KEY_FILE = "%d/age-master-key";
    serviceConfig.LoadCredential = "age-master-key:${
      config.sops.secrets."github-runner/age-master-key".path
    }";
  };
}
