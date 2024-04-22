{ lib, stdenv, fetchFromGitHub, meson, cmake, dmenu, pkg-config
, python312Packages }:

stdenv.mkDerivation (finalAttrs: {
  pname = "j4-dmenu-desktop";
  version = "develop feb 2024";

  src = fetchFromGitHub {
    owner = "enkore";
    repo = "j4-dmenu-desktop";
    rev = "bc58c2a3740817a9283b646c6374ebadbd27bf5e";
    hash = "sha256-lm6QAOL1dm7aXxS2faK7od7vK15blidHc8u5C5rCDqw=";
  };

  postPatch = ''
    substituteInPlace src/main.cc \
        --replace "dmenu -i" "${lib.getExe dmenu} -i"
  '';

  nativeBuildInputs = [ meson cmake pkg-config ];
  buildInputs = with python312Packages; [ loguru ];
  mesonBuildType = "release";
  mesonFlags = [ "-Db_lto=true" "--unity on" "--unity-size 9999" ];

  meta = with lib; {
    changelog =
      "https://github.com/enkore/j4-dmenu-desktop/blob/${finalAttrs.src.rev}/CHANGELOG";
    description = "A wrapper for dmenu that recognizes .desktop files";
    homepage = "https://github.com/enkore/j4-dmenu-desktop";
    license = licenses.gpl3Only;
    mainProgram = "j4-dmenu-desktop";
    maintainers = with maintainers; [ ericsagnes ];
    platforms = platforms.unix;
  };
})
