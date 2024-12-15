# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
{ pkgs ? import <nixpkgs> { }
,
}:
rec {
  kirsch = pkgs.callPackage ./kirsch { };
  sunbeam = pkgs.callPackage ./sunbeam { };
  bolt-launcher = pkgs.callPackage ./bolt-launcher { };
  wavetracker = pkgs.callPackage ./wavetracker { };
  plastic = pkgs.callPackage ./plastic { };
}
