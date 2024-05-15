{ pkgs, inputs, ... }: {
  imports = [ inputs.niri.homeModules.niri ./niri.nix ./waybar.nix ./i3.nix ./dunst.nix ];
  home.packages = with pkgs; [
    blueman
    xwayland
    wl-clipboard # copy to clipboard
  ];
  stylix.targets = { gtk.enable = true; };
  nixpkgs.overlays = [ inputs.niri.overlays.niri ];
}
