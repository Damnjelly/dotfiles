{
  lib,
  inputs,
  config,
  osConfig,
  pkgs,
  ...
}:
{
  config = lib.mkIf (builtins.elem config.home.username osConfig.features.games.enableFor) {
    home = {
      packages =
        let
          gamePkgs = inputs.nix-gaming.packages.${pkgs.hostPlatform.system};
        in
        with pkgs;
        [
          gamePkgs.osu-stable
          gamePkgs.osu-lazer-bin
          wineWowPackages.waylandFull
          wl-gammactl
        ];
      persistence = lib.mkIf osConfig.optinpermanence.enable {
        "/persist/home/${config.home.username}/osu" = {
          directories = [
            ".config/OpenTabletDriver"
            ".config/xfce4"
            ".local/share/osu"
            ".osu"
          ];
          allowOther = true;
        };
      };
      sessionVariables = {
        vblank_mode = 0;
      };
    };
  };
}
