{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}:
{
  options.features.music.enable = lib.mkEnableOption "music";

  config.home = lib.mkIf config.features.music.enable {
    packages = with pkgs; [
      amberol
      tagger
      adwaita-icon-theme
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
}
