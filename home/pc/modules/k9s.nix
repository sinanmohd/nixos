{
  programs.k9s = {
    enable = true;
    skins = {
      transparency = {
        k9s = {
          body.bgColor = "default";
          frame = {
            crumbs.bgColor = "default";
            title.bgColor = "default";

          };
          views = {
            table = {
              bgColor = "default";
              header.bgColor = "default";
            };
            logs.bgColor = "default";
          };
        };
      };
    };

    settings.ui.splashless = true;
  };
}
