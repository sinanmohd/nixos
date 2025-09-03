{
  config,
  pkgs,
  lib,
  ...
}:
let
  user = config.global.userdata.name;
in
{
  programs.firejail.wrappedBinaries.slack = {
    executable = lib.getExe pkgs.slack;
    profile = "${pkgs.firejail}/etc/firejail/slack.profile";
  };

  virtualisation.docker.enable = true;
  users.extraGroups.docker.members = [ user ];

  systemd.services.k3s.path = [ pkgs.criu ];
  environment = {
    variables.KUBECONFIG = "/etc/rancher/k3s/k3s.yaml";
    systemPackages = with pkgs; [
      kubernetes-helm
      k9s
    ];
  };
  services.k3s = {
    gracefulNodeShutdown.enable = true;
    enable = true;
    clusterInit = true;
    role = "server";
    extraFlags = [
      "--write-kubeconfig-group users"
      "--write-kubeconfig-mode 0640"
    ];
  };
}
