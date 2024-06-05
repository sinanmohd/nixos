{
  stdenvNoCC,
  lib,
  makeWrapper,

  bash,
  sway,
  ffmpeg,
  libnotify,
}:

stdenvNoCC.mkDerivation {
  pname = "wayland-scipts";
  version = "1717572072";
  src = ./src;

  strictDeps = true;
  outputs = [ "out" ];
  buildInputs = [ bash ];
  nativeBuildInputs = [ makeWrapper ];

  postPatch = ''
    for sh in bin/*; do
      patchShebangs --host "$sh"
    done
  '';

  installPhase = ''
    runHook preInstall
    cp -r ./ $out
    runHook postInstall
  '';

  postInstall = ''
    wrapProgram $out/bin/cwall \
      --prefix PATH : ${lib.makeBinPath [ ffmpeg libnotify sway ]}
  '';

  meta = {
    description = "Wayland scripts for sway";
    homepage = "https://www.sinanmohd.com";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.unix;
    maintainers = with lib.maintainers; [ sinanmohd ];
  };
}
