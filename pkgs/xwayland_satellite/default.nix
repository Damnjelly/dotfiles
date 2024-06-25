{
  lib,
  rustPlatform,
  fetchFromGitHub,
  clang,
  llvmPackages,
  xcb-util-cursor,
  xorg,
  musl,
  xwayland,
  makeWrapper,
  pkg-config,
}:

rustPlatform.buildRustPackage rec {
  pname = "xwayland-satellite";
  version = "f261e3feec27da5dcbb07db6abdaf0662d5f0db5";

  src = fetchFromGitHub {
    owner = "Supreeeme";
    repo = "xwayland-satellite";
    rev = version;
    sha256 = "sha256-lmFf7XEkTvdeOM6KxiHmAQLSkWzHLFqUqrHhtBterMg=";
  };

  cargoSha256 = "sha256-Tw50bUqtVbVBhQmMhhtY10xt2aaAriCJFauGltxeatI=";

  doCheck = false;

  LIBCLANG_PATH = lib.makeLibraryPath [ llvmPackages.libclang.lib ];
  BINDGEN_EXTRA_CLANG_ARGS =
    (builtins.map (a: ''-I"${a}/include"'') [
      xcb-util-cursor.dev
      xorg.libxcb.dev
      musl.dev
    ])
    ++ [ "-isystem ${llvmPackages.libclang.lib}/lib/clang/${lib.getVersion clang}/include" ];

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [
    xcb-util-cursor
    clang
    makeWrapper
  ];

  postInstall = ''
    wrapProgram $out/bin/xwayland-satellite \
      --prefix PATH : "${lib.makeBinPath [ xwayland ]}"
  '';

  meta = with lib; {
    description = "Xwayland outside your Wayland";
    license = licenses.mpl20;
    homepage = src.meta.homepage;
    platforms = platforms.linux;
    maintainers = with maintainers; [ gabby ];
  };
}
