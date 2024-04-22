{ ... }: {
  home.file.".local/share/applications/steam-gamescope.desktop".text = ''
    [Desktop Entry]
    Name=Steam Wayland
    Exec=gamescope -- steam
    Type=Application
  '';
}
