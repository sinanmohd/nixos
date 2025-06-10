{ pkgs, lib, ... }:
{
  environment = {
    binsh = lib.getExe pkgs.dash;
    systemPackages = with pkgs; [
      dash
      neovim
    ];

    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    shellAliases = {
      grep = "grep --color=auto";
      ls = "ls --color=auto --group-directories-first";
    };
  };
}
