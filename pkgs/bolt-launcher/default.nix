{
  stdenv,
  fetchFromGitHub,
  fetchzip,
  cmake,
  ninja,
  xorg,
  libarchive,
}:
let
  name = "Bolt";
  version = "0.9.0";

  cef = fetchzip {
    url = "https://adamcake.com/cef/cef-114.0.5735.134-linux-x86_64-minimal-ungoogled.tar.gz";
    hash = "sha256-hc8PAGWom+iUljDQHs2pGoXUGmYcButcPBHjKpUh9vA=";
  };
in
stdenv.mkDerivation {
  inherit name;

  src = fetchFromGitHub {
    owner = "Adamcake";
    repo = name;
    rev = version;
    hash = "sha256-LIlRDcUWbQwIhFjtqYF+oVpTOPZ7IT0vMgysEVyJ1k8=";
    fetchSubmodules = true;
  };

  prePatch = ''
    ln -s ${cef} cef/dist 
  '';

  nativeBuildInputs = [
    cmake
    ninja
  ];

  buildInputs = with xorg; [
    libX11.dev
    libxcb.dev
    libarchive
  ];

  cmakeFlagsArray = [
    "-DBOLT_SKIP_LIBRARIES=1"
    "-DCMAKE_BUILD_TYPE=Release"
  ];
}
