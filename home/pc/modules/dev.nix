{ pkgs, ... }: {
  programs.man.enable = true;

  home.packages = with pkgs; [
    git
    sops

    man-pages
    man-pages-posix

    nil
    nodePackages.bash-language-server
  ];
}
