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
      packages = with pkgs; [ prismlauncher ];
      persistence = lib.mkIf osConfig.optinpermanence.enable {
        "/persist/home/${config.home.username}/primslauncher" = {
          directories = [ ".local/share/PrismLauncher" ];
          allowOther = true;
        };
      };
    };
  };
}
