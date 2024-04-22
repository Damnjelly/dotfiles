{ pkgs, ... }: {
  imports = [
    ./steam.nix
  ];
  home.packages = with pkgs; [
    monspkgs.everest-mons
    opentabletdriver
    osu-lazer-bin
    #inputs.nix-gaming.packages.${pkgs.system}.osu-stable
    r2modman
    runelite
  ];
}
