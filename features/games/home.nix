{ pkgs, ... }:
{
  imports = [
    ./godot
    ./minecraft
    ./openrct2
    ./osrs
    ./osu/home.nix
    ./steam/home.nix
  ];
}
