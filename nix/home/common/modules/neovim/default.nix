{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # telescope
    ripgrep
    fd
    # lazy
    gcc
    gnumake
    # toggleterm
    tmux
  ];

  xdg.configFile.nvim.source = ./config;
}
