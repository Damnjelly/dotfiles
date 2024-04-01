{pkgs, ...}: {
  imports = [
    ./hyprland.nix
    ./eww.nix
  ];
  home.packages = with pkgs; [
    grim # create screenshot
    slurp # get screen region
    wl-clipboard # copy to clipboard
    swww # wallpaper daemon
    xdg-desktop-portal # desktop portal
    xdg-desktop-portal-gtk
    rofi-wayland # applauncher
    dunst # notification daemon
    eww # widget system
  ];
}
