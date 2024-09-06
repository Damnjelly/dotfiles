{ lib, config, ... }:
{
  home = {
    persistence = lib.mkIf config.optinpermanence.enable {
      "/persist/home/${config.home.username}/osu" = {
        directories = [
          ".local/share/osu"
          ".config/OpenTabletDriver" 
          ".config/xfce4" 
          ".osu"
        ];
        allowOther = true;
      };
    };
    sessionVariables = {
      vblank_mode = 0;
    };
  };
}
