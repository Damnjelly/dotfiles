{ pkgs, config, ... }: {
  home = {
    packages = with pkgs; [ runelite ];
    file.".local/share/applications/steamwayland.desktop".text = ''
      [Desktop Entry]
      Name=Steam Wayland
      Exec=$SCRIPT_XWAYLAND steam
      Type=Application
    '';
   persistence."/persist/home/${config.home.username}/steam" = {
     directories = [ 
       {
        directory = ".local/share/Steam";
        method = "symlink";
      }
       ".local/share/Celeste"
     ];
     allowOther = true;
   };
  };
}
