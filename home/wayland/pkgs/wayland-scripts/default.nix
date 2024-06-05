{
  stdenvNoCC,
  lib,
  makeWrapper,

  bash,
  sway,
  ffmpeg,
  libnotify,
  imv,
  grim,
  slurp,
}:

stdenvNoCC.mkDerivation {
  pname = "wayland-scipts";
  version = "1717606223";
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
    wrapProgram $out/bin/freezshot \
      --prefix PATH : ${lib.makeBinPath [ ffmpeg sway grim slurp imv ]}
  '';

  meta = {
    description = "Wayland scripts for sway";
    homepage = "https://www.sinanmohd.com";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.unix;
    maintainers = with lib.maintainers; [ sinanmohd ];
  };
}
