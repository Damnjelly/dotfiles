{ pkgs, lib, config, ... }: {
  home = {
    packages = with pkgs; [ runelite ];
    file.".local/share/applications/runelitewayland.desktop".text = ''
      [Desktop Entry]
      Name=Runelite Wayland
      Exec=$SCRIPT_XWAYLAND runelite 1803 1006
      Type=Application
    '';
    home.persistence = lib.mkIf config.optinpermanence.enable {
     "/persist/home/${config.home.username}/runelite" = {
        directories = [ ".runelite" ];
        allowOther = true;
      };
    };
  };
}
