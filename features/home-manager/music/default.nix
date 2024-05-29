{ pkgs, ... }: {
  imports = [ ./g4music.nix ];
  home.packages = with pkgs; [
    g4music
    tagger
    clematis
    gnome.adwaita-icon-theme
  ];
}
