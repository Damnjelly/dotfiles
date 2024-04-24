{ pkgs, inputs, ... }: {
  imports = [ ./niri.nix ./waybar.nix ./i3.nix ];
  home.packages = with pkgs; [ 
    xwayland 
    cage 
    gamescope 
    blueman # bluetooth manager
    dwm
    steam-tui
    steamPackages.steamcmd
  ];
  stylix.targets = { gtk.enable = true; };
  nixpkgs.overlays = [ inputs.niri.overlays.niri ];
}
