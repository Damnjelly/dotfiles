{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}:
{
  config = lib.mkIf (builtins.elem config.home.username osConfig.features.games.enableFor) {
    home = {
      packages = with pkgs; [ runelite ];
      persistence = lib.mkIf osConfig.optinpermanence.enable {
        "/persist/home/${config.home.username}/runelite" = {
          directories = [ ".runelite" ];
          allowOther = true;
        };
      };
    };
  };
}
