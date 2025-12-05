{
  config,
  pkgs,
  lib,
  ...
}:
let
  heater = pkgs.writeShellApplication {
    name = "heater";
    runtimeInputs = with pkgs; [
      vulkan-tools
      mangohud
    ];

    text = ''
      MESA_VK_WSI_PRESENT_MODE=immediate mangohud vkcube --present_mode 0
    '';
  };
  username = config.global.userdata.name;
in
{
  imports = [ ./nvidia.nix ];

  services.logind.settings.Login.HandleLidSwitch = "ignore";
  environment.systemPackages = [ heater ];
  home-manager.users.${username}.imports = [
    {
      wayland.windowManager.sway.settings.exec = [ "${lib.getExe heater}" ];
    }
  ];
}
