{ pkgs, inputs, ... }:
{
  imports = [
    ./osu.nix
    ./steam.nix
    ./runelite.nix
    ./openrct2.nix
    ./prismlauncher.nix
  ];
  home.packages =
    let
      gamePkgs = inputs.nix-gaming.packages.${pkgs.hostPlatform.system};
    in
    with pkgs;
    [
      everest-mons
      gamePkgs.osu-stable
      wineWowPackages.waylandFull
      osu-lazer-bin
      r2modman
      wl-gammactl
      #bolt-launcher
    ];
}
