{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nodePackages.bash-language-server
    nil
    ccls
    lua-language-server
    man-pages
    man-pages-posix
  ];

  documentation.dev.enable = true;
}
