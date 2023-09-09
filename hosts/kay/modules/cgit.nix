{ config, pkgs, ... }:

let
  domain = config.userdata.domain;
  user = config.userdata.user;
in
{
  services = {
    nginx.virtualHosts."git.${domain}" = {
      forceSSL = true;
      enableACME = true;
    };
    cgit."git.${domain}" = {
      enable = true;
      nginx.virtualHost = "git.${domain}";
      scanPath = "/var/lib/git";
      settings = {
        project-list = "/var/lib/git/project.list";
        remove-suffix = 1;
        enable-commit-graph = 1;
        root-title = "${user}'s git server";
        root-desc = "how do i learn github anon";
        source-filter = "${pkgs.cgit}/lib/cgit/filters/syntax-highlighting.py";
        clone-url = "https://git.${domain}/$CGIT_REPO_URL";
      };
    };
  };
}
