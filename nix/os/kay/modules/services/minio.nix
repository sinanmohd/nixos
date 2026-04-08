{
  config,
  lib,
  pkgs,
  ...
}:
let
  email = config.global.userdata.email;
in
{
  sops.secrets."misc/default_password" = { };
  systemd.services.minio.serviceConfig.LoadCredential = [
    "password:${config.sops.secrets."misc/default_password".path}"
  ];

  services.minio = {
    enable = true;
    consoleAddress = ":9003";

    package = pkgs.stdenv.mkDerivation {
      name = "minio-with-secrets";
      dontUnpack = true;
      buildInputs = with pkgs; [
        makeWrapper
        minio
      ];
      installPhase = ''
        mkdir -p $out/bin
        makeWrapper ${lib.getExe pkgs.minio} $out/bin/minio \
          --run 'echo "Seting Minio Secrets"' \
          --set MINIO_ROOT_USER ${email} \
          --run 'export MINIO_ROOT_PASSWORD="$(cat "$CREDENTIALS_DIRECTORY"/password)"'
      '';
    };
  };
}
