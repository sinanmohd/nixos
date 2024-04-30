{ lib, ... }: {
    programs.zathura = {
    enable = true;

    mappings = {
      "f" = "toggle_fullscreen";
      "[fullscreen] f" = "toggle_fullscreen";
    };
    options = {
      font = lib.mkDefault "Sans";
      statusbar-basename = true;
      selection-clipboard = "clipboard";
    };
  };
}
