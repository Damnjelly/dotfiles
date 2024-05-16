{ lib, buildGoModule, fetchFromGitHub }:
let
  pname = "sunbeam";
  version = "v1.0.0";
in buildGoModule {
  name = pname;
  src = fetchFromGitHub {
    owner = "pomdtr";
    repo = pname;
    rev = version;
    hash = "sha256-X5LPRrI5VVCLnZLrjLyocexmReS5RdmQyJbbAvwFxs0=";
  };
  vendorHash = "sha256-V3dpE2V08PBp4nJuSuOH8VeTqqnC34kGT/ZdrxtV0W4=";

  meta = with lib; {
    homepage = "https://sunbeam.deno.dev/";
    description =
      "Sunbeam is a general purpose CLI launcher. It allows you to wrap your tools in slick UIs with a few lines of code, using the language of your choice.";
    license = licenses.mit;
    #maintainers = with maintainers; [ Gelei ];
    platforms = [ "x86_64-linux" ]; # this is the only system i can test
  };
}
