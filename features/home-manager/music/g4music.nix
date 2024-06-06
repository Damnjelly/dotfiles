{ lib, config, ... }: {
  home = {
    persistence = lib.mkIf config.optinpermanence.enable {
      "/persist/home/${config.home.username}/g4music" = {
        directories = [ ".cache/com.github.neithern.g4music" ];
        allowOther = true;
      };
    };
    sessionVariables = { MUSIC = "g4music"; };
  };
  programs.niri.settings.spawn-at-startup =
    lib.mkIf config.programs.niri.enable [{ command = [ "clematis" ]; }];
}
