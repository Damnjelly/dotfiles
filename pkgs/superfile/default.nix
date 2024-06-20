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
      rev = "v${version}";
      hash = "sha256-z1jcRzID20s7tEDUaEcnOYBfv/BPZtcXz9fy3V5iPPg=";
    };

  vendorHash = "sha256-OzPH7dNu/V4HDGSxrvYxu3s+hw36NiulFZs0BJ44Pjk=";

  meta = {
    changelog = "https://github.com/yorukot/superfile/blob/v${version}/changelog.md";
    description = "Pretty fancy and modern terminal file manager";
    homepage = "https://github.com/yorukot/superfile";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ momeemt ];
    mainProgram = "superfile";
  };
}
