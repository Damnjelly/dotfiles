{ lib, fetchzip }:
let
  pname = "sunbeam-bin";
  version = "v1.0.0";
in fetchzip {
  name = "${pname}-${version}";

  url =
    "https://github.com/pomdtr/sunbeam/releases/download/${version}/sunbeam-linux_amd64.tar.gz";
  sha256 = "sha256-Q6ZIooUBn6V8CAOxflY4nprCZFRyEK0BVCBXUna2ICs=";
  stripRoot = false;

  postFetch = ''
    mkdir -p $out/bin
    mv $out/sunbeam $out/bin
  '';

  meta = with lib; {
    homepage = "https://sunbeam.deno.dev/";
    description =
      "Sunbeam is a general purpose CLI launcher. It allows you to wrap your tools in slick UIs with a few lines of code, using the language of your choice.";
    license = licenses.mit;
    #maintainers = with maintainers; [ Gelei ];
    platforms = [ "x86_64-linux" ]; # this is the only system i can test
  };
}
