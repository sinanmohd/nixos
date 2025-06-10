{
  lib,
  stdenvNoCC,
  fetchFromGitLab,
  makeWrapper,

  pandoc,
  rsync,
  bash,
  hostname,
}:

stdenvNoCC.mkDerivation {
  pname = "archvsync";
  version = "unstable-2024-02-17";

  src = fetchFromGitLab {
    domain = "salsa.debian.org";
    owner = "mirror-team";
    repo = "archvsync";
    rev = "653357779c338863917aa069afbae1b24472d32d";
    hash = "sha256-vI32Cko5jXY/aZI9hKWm3GI26Oy89M5VLUFWBk1HNXQ=";
  };

  strictDeps = true;
  nativeBuildInputs = [
    makeWrapper
    pandoc
  ];
  outputs = [
    "out"
    "man"
    "doc"
  ];

  patches = [
    ./Makefile.patch
    ./common.patch
  ];

  postInstall = ''
    for s in $out/bin/*; do
      wrapProgram $s --prefix PATH : ${
        lib.makeBinPath [
          rsync
          bash
          hostname
        ]
      }
    done
  '';

  makeFlags = [
    "OUT=${placeholder "out"}"
    "MAN=${placeholder "man"}"
    "DOC=${placeholder "doc"}"
  ];

  meta = with lib; {
    description = "Scripts for maintaining a Debian archive mirror";
    homepage = "https://salsa.debian.org/mirror-team/archvsync";
    license = licenses.gpl2;
    platforms = platforms.all;
    maintainers = with maintainers; [ sinanmohd ];
    mainProgram = "ftpsync";
  };
}
