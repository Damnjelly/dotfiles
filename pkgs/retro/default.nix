{ lib, buildGoModule, fetchFromGitHub }:
let
  pname = "retro";
  version = "retro-v0.0.30";
in buildGoModule {
  name = pname;
  src = fetchFromGitHub {
    owner = "Malwarize";
    repo = pname;
    rev = version;
    hash = "";
  };
  vendorHash = "";

  meta = with lib; {
    homepage = "https://github.com/Malwarize/retro";
    description =
      "play music and continue your work on the terminal.";
    license = licenses.mit;
    #maintainers = with maintainers; [ Gelei ];
    platforms = [ "x86_64-linux" ]; # this is the only system i can test
  };
}
