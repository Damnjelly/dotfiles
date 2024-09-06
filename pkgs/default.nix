# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
{
  pkgs ? import <nixpkgs> { },
}:
rec {
  kirsch = pkgs.callPackage ./kirsch { };
  sunbeam = pkgs.callPackage ./sunbeam { };
  xwayland-satellite = pkgs.callPackage ./xwayland_satellite { };
  bolt-launcher = pkgs.callPackage ./bolt-launcher { };
}
