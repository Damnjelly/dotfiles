{ pkgs, inputs, ... }: {
  imports = [ inputs.niri.homeModules.niri ./niri.nix ./waybar.nix ];
  home.packages = with pkgs; [
    xwayland
    wl-clipboard # copy to clipboard
    g4music
    valent
    gnome.adwaita-icon-theme
    xwayland-satellite
  ];
  stylix.targets = { gtk.enable = true; };
  nixpkgs.overlays = [ inputs.niri.overlays.niri ];
}
