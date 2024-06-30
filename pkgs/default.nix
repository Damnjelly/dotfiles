# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
{
  pkgs ? import <nixpkgs> { },
}:
rec {
  kirsch = pkgs.callPackage ./kirsch { };
  sunbeam = pkgs.callPackage ./sunbeam { };
  geleisuperfile = pkgs.callPackage ./superfile { };
  xwayland-satellite = pkgs.callPackage ./xwayland_satellite { };
  geleiopenrct2 = pkgs.callPackage ./openrct2 { };
  bolt-launcher = pkgs.callPackage ./bolt-launcher { };
}
