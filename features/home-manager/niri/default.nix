{ pkgs, inputs, ... }:
{
  imports = [
    inputs.niri.homeModules.niri
    ./niri.nix
    ./waybar.nix
  ];
  home.packages = with pkgs; [
    xwayland
    wl-clipboard # copy to clipboard
    g4music
    gnome.adwaita-icon-theme
    xwayland-satellite
    polkit_gnome
  ];
  stylix.targets = {
    gtk.enable = true;
  };
  nixpkgs.overlays = [ inputs.niri.overlays.niri ];
}
