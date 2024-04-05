{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    teams-for-linux
    hackneyed
    remmina
    monspkgs.everest-mons
    #Utility
    opentabletdriver
    zathura
    vesktop

    #Games
    osu-lazer-bin
    inputs.nix-gaming.packages.${pkgs.system}.osu-stable
    r2modman
    stable.runelite

    #Creative
    godot_4
    blender
  ];

  fonts.packages = with pkgs; [
    kirsch
  ];
}
