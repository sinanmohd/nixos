{ pkgs, ... }: {
  home.packages = with pkgs; [
    git
    sops

    linux-manual
    man-pages
    man-pages-posix

    nil
    nodePackages.bash-language-server
  ];
}
