{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # telescope
    ripgrep
    fd
    # lazy
    gcc
    gnumake
  ];

  xdg.configFile.nvim.source = ./config;
}
