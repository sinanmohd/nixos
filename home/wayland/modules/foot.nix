{ lib, ... }: {
  programs.foot = {
    enable = true;

    settings = {
      colors.background = "000000";
      main = {
        pad = "10x10";
        font = lib.mkDefault "monospace:size=18";
      };
    };
  };
}
