# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
{pkgs ? import <nicpkgs> { } }: rec {
  # example = pkgs.callPackage ./example { };
  kirsch = pkgs.callPackage ./kirsch { };
}
