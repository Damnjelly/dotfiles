{ pkgs, ... }: {
imports = [ ./hyprland.nix ./rofi.nix ];
  home.packages = with pkgs; [
    grim # create screenshot
    slurp # get screen region
    wl-clipboard # copy to clipboard
    swww # wallpaper daemon
    xdg-desktop-portal # desktop portal
    xdg-desktop-portal-gtk
    dunst # notification daemon
    rofi-wayland # app launcher
    hyprpicker # colorpicker
  ];
}
