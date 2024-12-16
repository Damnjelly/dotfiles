{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}:
{
  options.features.music.enable = lib.mkEnableOption "music";

  config = {
    home = lib.mkIf config.features.music.enable {
      packages = with pkgs; [
        amberol
        tagger
        adwaita-icon-theme
        rmpc
      ];
      persistence = lib.mkIf osConfig.optinpermanence.enable {
        "/persist/home/${config.home.username}/music" = {
          directories = [ ".cache/amberol" ];
          allowOther = true;
        };
      };
      sessionVariables = {
        MUSIC = "amberol";
      };
    };
    services.mpd = {
      enable = true;
      musicDirectory = "${config.home.homeDirectory}/Music";
      extraConfig = ''
      audio_output {
        type "pipewire"
        name "Starship/Matisse HD Audio Controller Analog Stereo"
      }
      '';
    };
  };
}
