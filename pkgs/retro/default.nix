{
  lib,
  buildGoModule,
  makeWrapper,
  pkg-config,
  alsa-lib,
  ffmpeg,
  yt-dlp,
  bash-completion,
  fetchFromGitHub,
}:
let
  pname = "retro";
  version = "v0.0.30";
in
buildGoModule {
  name = pname;
  src = fetchFromGitHub {
    owner = "Malwarize";
    repo = pname;
    rev = version;
    hash = "sha256-H4g8l4wwldHmBQ2qVOUw1rPDjZwHqE66uUBKPxE52n0=";
  };
  vendorHash = "sha256-ulMVoqVsOYLTzCJZV9Al5w56dQfwa4toaBZZsKC4stY=";

  nativeBuildInputs = [
    makeWrapper
    pkg-config
  ];
  buildInputs = [ alsa-lib.dev ];
  # propagatedBuildInputs = [ yt-dlp ffmpeg bash-completion ];

  postInstall = ''
    mv $out/bin/client $out/bin/retro
    mv $out/bin/server $out/bin/retroPlayer

    wrapProgram $out/bin/retroPlayer \
      --prefix PATH : ${
        lib.makeBinPath [
          yt-dlp
          ffmpeg
          bash-completion
        ]
      }
  '';

  meta = with lib; {
    homepage = "https://github.com/Malwarize/retro";
    description = "play music and continue your work on the terminal.";
    license = licenses.mit;
    #maintainers = with maintainers; [ Gelei ];
    platforms = [ "x86_64-linux" ]; # this is the only system i can test
  };
}
