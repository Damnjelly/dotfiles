{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    teams-for-linux
    hackneyed
    remmina
    vesktop

    #Creative
    godot_4
    blender
  ];
  fonts.packages = with pkgs; [ kirsch cozette ];
}
