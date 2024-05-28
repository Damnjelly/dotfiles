{ pkgs, ... }: {
  imports = [ ./g4music.nix ];
  home.packages = with pkgs; [
    g4music
    tagger
    clematishl
    gnome.adwaita-icon-theme
  ];
}
