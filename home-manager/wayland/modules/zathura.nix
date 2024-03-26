{ ... }: {
    programs.zathura = {
    enable = true;

    mappings = {
      "f" = "toggle_fullscreen";
      "[fullscreen] f" = "toggle_fullscreen";
    };
    options = {
      "font" = "Sans";
      "statusbar-basename" = true;
      "selection-clipboard" = "clipboard";
    };
  };
}
