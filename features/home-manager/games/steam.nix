{ ... }: {
  home.file.".local/share/applications/steam-gamescope.desktop".text = ''
    [Desktop Entry]
    Name=Steam Wayland
    Exec=$SCRIPT_XWAYLAND steam
    Type=Application
  '';
}
