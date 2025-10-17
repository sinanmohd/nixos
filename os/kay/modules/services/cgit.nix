{ config, pkgs, ... }:

let
  domain = config.global.userdata.domain;
  user = config.global.userdata.name;
in
{
  users.users.${user}.packages = with pkgs; [ git ];
  environment.systemPackages = with pkgs; [
    luajitPackages.luaossl
    lua52Packages.luaossl
  ];

  services.cgit."git.${domain}" = {
    enable = true;
    nginx.virtualHost = "git.${domain}";
    scanPath = "/var/lib/git";
    settings = {
      project-list = "/var/lib/git/project.list";
      remove-suffix = 1;
      enable-commit-graph = 1;
      root-title = "${user}'s git repository";
      root-desc = "how do i learn github anon";
      source-filter = "${pkgs.cgit}/lib/cgit/filters/syntax-highlighting.py";
      about-filter = "${pkgs.cgit}/lib/cgit/filters/about-formatting.sh";
      readme = ":README.md";
      footer = "";
      enable-blame = 1;
      clone-url = "https://git.${domain}/$CGIT_REPO_URL";
      enable-log-filecount = 1;
      enable-log-linecount = 1;
    };
  };
}
