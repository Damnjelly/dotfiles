{
  pkgs,
  lib,
  config,
  ...
}:
{
  home = {
    packages = with pkgs; [ runelite ];
    persistence = lib.mkIf config.optinpermanence.enable {
      "/persist/home/${config.home.username}/runelite" = {
        directories = [ ".runelite" ];
        allowOther = true;
      };
    };
  };
}
