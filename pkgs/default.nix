# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
{ pkgs ? import <nixpkgs> { } }: rec {
  # example = pkgs.callPackage ./example { };
  kirsch = pkgs.callPackage ./kirsch { };
  sunbeam-bin = pkgs.callPackage ./sunbeam-bin { };
  #j4-dmenu-desktop = pkgs.callPackage ./j4-dmenu-desktop { };
}
