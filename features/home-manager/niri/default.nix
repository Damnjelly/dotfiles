{ pkgs, inputs, ... }: {
  imports = [
    # inputs.niri.homeModules.niri 
    ./niri.nix
    ./waybar.nix
    ./i3.nix
  ];
  home.packages = with pkgs; [
    xwayland
    swww
    blueman # bluetooth manager
    wl-clipboard # copy to clipboard
    waybar
  ];
  stylix.targets = { gtk.enable = true; };
  nixpkgs.overlays = [ inputs.niri.overlays.niri ];
}
