{ lib, fetchzip }:
let
  pname = "kirsch";
  version = "v0.0.6";
in fetchzip {
  name = "${pname}-${version}";

  url = "https://github.com/molarmanful/kirsch/releases/download/${version}/kirsch_${version}.zip";
  sha256 = "sha256-CcwXKdw2al7sOA0JStT1RevAHy2RkjMKKvkN21di7no=";

  postFetch = ''
    mkdir -p $out/share/fonts/misc
    mv $out/*.otb $out/share/fonts/misc
    rm $out/kirsch*
  '';

  meta = with lib; {
    homepage = "https://github.com/molarmanful/kirsch";
    description = "A monospace bitmap font that draws from a variety of letterforms and motifs to create a distinct humanist feel at a compact size";
    license = licenses.ofl;
    platforms = platforms.all;
    #maintainers = with maintainers; [ Gelei ];
  };
}
