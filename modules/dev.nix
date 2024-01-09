{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gcc
    git
    lua

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
