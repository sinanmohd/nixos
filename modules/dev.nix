{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    shellcheck
    gnumake
    gcc
    nodePackages.bash-language-server
    nodePackages.pyright
    nil
    ccls
    lua-language-server
    man-pages
    man-pages-posix
  ];

  documentation.dev.enable = true;
}
