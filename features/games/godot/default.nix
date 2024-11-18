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
      packages = with pkgs; [ godot_4 ];
      persistence = lib.mkIf osConfig.optinpermanence.enable {
        "/persist/home/${config.home.username}/godot" = {
          directories = [
            ".config/godot"
            ".local/share/godot"
          ];
          allowOther = true;
        };
      };
    };
  };
}
