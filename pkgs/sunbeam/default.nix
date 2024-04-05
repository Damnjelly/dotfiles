{ lib
, buildGoModule
, fetchzip 
}: 
buildGoModule rec {
  pname = "sunbeam";
  version = "v1.0.0";

  src = fetchzip {
    name = "${pname}-${version}";
    url = "https://github.com/pomdtr/sunbeam/releases/tag/${version}.tar.gz";
    sha256 = lib.fakeSha256;
  };

  vendorHash = lib.fakeHash;

  meta = with lib; {
    homepage = "https://sunbeam.deno.dev/";
    description = "Sunbeam is a general purpose CLI launcher. It allows you to wrap your tools in slick UIs with a few lines of code, using the language of your choice.";
    license = licenses.mit;
    maintainers = with maintainers; [ Gelei ];
  };
}
