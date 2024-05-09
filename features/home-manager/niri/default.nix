{ pkgs, inputs, ... }: {
  imports = [ ./niri.nix ./waybar.nix ./i3.nix ];
  home.packages = with pkgs; [
    swww
    xwayland
    wl-clipboard # copy to clipboard
  ];
  stylix.targets = { gtk.enable = true; };
  nixpkgs.overlays = [ inputs.niri.overlays.niri ];
}
