{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  systemd,
  alsa-lib,
}:
rustPlatform.buildRustPackage rec {
  pname = "plastic";
  version = "v0.3.4";

  src = fetchFromGitHub {
    owner = "Amjad50";
    repo = pname;
    rev = version;
    sha256 = "sha256-mqeA4+xFRRzd2zeur7eiifJjyU6ClcwCenwy9lrHTAQ=";
  };

  cargoHash = "sha256-Dq5Gk/3eK7JJrUiGXx6g5wTVcV+yk+nf36xRjU2CLtc=";

  cargoBuildFlags = [ "-p=plastic_tui" ];

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    systemd # https://discourse.nixos.org/t/solved-libudev-replaced-by-udev/18951
    alsa-lib
  ];

  meta = with lib; {
    description = "A fast line-oriented regex search tool, similar to ag and ack";
    homepage = "https://github.com/BurntSushi/ripgrep";
    license = licenses.unlicense;
    maintainers = [ gelei ];
  };
}
