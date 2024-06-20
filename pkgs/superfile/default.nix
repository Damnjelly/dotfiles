{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
let
  version = "1.1.3";
in
buildGoModule {
  pname = "superfile";
  inherit version;

  src =
    fetchFromGitHub {
      owner = "yorukot";
      repo = "superfile";
      rev = "1a15d23ebbdf84fec98725b7635e6071e61163a2";
      hash = "sha256-pgPdvdB9J7MA99yRgISyAS4RR7BPXe3WgzeG/F4xSLE=";
    };

  vendorHash = "sha256-750y77tT2CtkuELyr6fDc7DjIWyYyTM4qDHx4lgvLmc=";

  meta = {
    changelog = "https://github.com/yorukot/superfile/blob/v${version}/changelog.md";
    description = "Pretty fancy and modern terminal file manager";
    homepage = "https://github.com/yorukot/superfile";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ momeemt ];
    mainProgram = "superfile";
  };
}
