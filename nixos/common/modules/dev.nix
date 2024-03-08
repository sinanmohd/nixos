{ config, pkgs, ... }:

let
  user = config.userdata.name;
in
{
  users.users.${user}.packages = with pkgs; [
    gcc
    git
    lua

    (python3.withPackages (p: with p; [
      pip
      build
    ]))

    man-pages
    man-pages-posix

    ccls
    lua-language-server
    nil
    nodePackages.bash-language-server
    nodePackages.pyright
    shellcheck
  ];

  documentation.dev.enable = true;
}
