{ pkgs, ... }:
{
  imports = [
    ./osu.nix
    ./steam.nix
    ./runelite.nix
    ./openrct2.nix
    ./prismlauncher.nix
  ];
  home.packages = with pkgs; [
    monspkgs.everest-mons
    opentabletdriver
    osu-lazer-bin
    #inputs.nix-gaming.packages.${pkgs.system}.osu-stable
    r2modman
    wl-gammactl
    #bolt-launcher
  ];
}
