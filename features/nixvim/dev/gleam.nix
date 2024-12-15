{ lib, pkgs, ... }:
let
  myGleam = pkgs.gleam.overrideAttrs
    (p: rec {
      pname = "gleam";
      version = "rev b96a39c6d107b43cd32382836b797e15b08d4cbd";

      src = pkgs.fetchFromGitHub {
        owner = "gleam-lang";
        repo = pname;
        rev = "b96a39c6d107b43cd32382836b797e15b08d4cbd";
        hash = "sha256-NPXKg1cpFSPbR955kVT21w45le6VBIxcRxbgE6w8NUM=";
      };
      cargoDeps = p.cargoDeps.overrideAttrs (
        lib.const {
          name = "${pname}-vendor.tar.gz";
          inherit src;
          outputHash = "sha256-hIgNOJK6YEyvGoWlU7E5tZuVa8WJAPfdsEOI7OZj214=";
        }
      );
    });
in
{
  home = {
    packages = [ myGleam ];
    shellAliases = {
      glr = "gleam run";
      glt = "gleam test";
      glrl = "gleam run -m lustre/dev start";
    };
  };
  programs.nixvim.plugins = {
    lsp.servers.gleam = {
      enable = true;
      package = myGleam;
      settings.formatting.command = [ "gleam format" ];
      extraOptions = {
        offset_encoding = "utf-8";
      };
    };
  };
}
