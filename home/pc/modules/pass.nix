{ config, pkgs, lib, ... }: let
  passStore = config.xdg.dataHome + "/pass";
  GNUPGHome = config.xdg.dataHome + "/gnupg";
in {
  home = {
    file."${GNUPGHome}/gpg-agent.conf".text = ''
      pinentry-program ${lib.getExe pkgs.pinentry-bemenu}
    '';

    packages = with pkgs; [
      pinentry-bemenu
      (pass.withExtensions (exts: [ exts.pass-otp ]))
    ];

    sessionVariables = {
      PASSWORD_STORE_DIR = passStore;
      GNUPGHOME = GNUPGHome;
    };
  };
}
