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

  specialisation.k3s.configuration = {
    systemd.services.k3s.path = [ pkgs.criu ];
    environment = {
      variables.KUBECONFIG = "/etc/rancher/k3s/k3s.yaml";
      systemPackages = with pkgs; [
        kubernetes-helm
        k9s
      ];
    };
    services.k3s = {
      enable = true;
      gracefulNodeShutdown.enable = true;
      clusterInit = true;
      role = "server";
      extraFlags = [
        "--write-kubeconfig-group users"
        "--write-kubeconfig-mode 0640"
        # disabled because some wifi won't have IPv6 (2025 edition), and k3s fails on startup
        # uncomment this to enble IPv6 ingress when humanity transcends
        # "--cluster-cidr=10.42.0.0/16,fd12:b0d8:b00b::/56"
        # "--service-cidr=10.43.0.0/16,fd12:b0d8:babe::/112"
        # "--flannel-ipv6-masq"
      ];
      manifests.traefik-daemonset = {
        enable = true;
        source = ./traefik-daemonset.yaml;
        target = "traefik-daemonset.yaml";
      };
    };
  };
}
