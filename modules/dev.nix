{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    shellcheck
    git
    gnumake
    gcc
    nodePackages.bash-language-server
    nodePackages.pyright
    nil
    ccls
    lua
    lua-language-server
    man-pages
    man-pages-posix
  ];

  documentation.dev.enable = true;
}
