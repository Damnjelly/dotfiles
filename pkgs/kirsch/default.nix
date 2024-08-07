{ lib, fetchzip }:
let
  pname = "kirsch";
  version = "v0.0.8";
in
fetchzip {
  name = "${pname}-${version}";

  url = "https://github.com/molarmanful/kirsch/releases/download/${version}/kirsch_${version}.zip";
  sha256 = "sha256-HCVSmkBlwmcoI8YV4YUpsY94IdCaE60pdvXob4y5X1M=";

  postFetch = ''
    mkdir -p $out/share/fonts/misc
    mv $out/*.otb $out/share/fonts/misc
    mv $out/*.pcf $out/share/fonts/misc
    mv $out/*.dfont $out/share/fonts/misc

    mkdir -p $out/share/fonts/woff2
    mv $out/*.woff2 $out/share/fonts/woff2

    mkdir -p $out/share/fonts/truetype
    mv $out/*.ttf $out/share/fonts/truetype
  '';

  meta = with lib; {
    homepage = "https://github.com/molarmanful/kirsch";
    description = "A monospace bitmap font that draws from a variety of letterforms and motifs to create a distinct humanist feel at a compact size";
    license = licenses.ofl;
    platforms = platforms.all;
    #maintainers = with maintainers; [ Gelei ];
  };
}
