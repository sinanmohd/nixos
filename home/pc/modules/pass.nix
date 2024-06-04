{ pkgs, ... }: {
  home.packages = with pkgs; [
    (pass.withExtensions (exts: [ exts.pass-otp ]))
  ];

  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-bemenu;
  };
}
