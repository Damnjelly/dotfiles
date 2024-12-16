{
  lib,
  pkgs,
  config,
  osConfig,
  ...
}:
{
  config = lib.mkIf (builtins.elem config.home.username osConfig.features.games.enableFor) {
    home = {
      packages = with pkgs; [
        dotnet-sdk_8
        everest-mons
        plastic
        r2modman
      ];
      persistence = lib.mkIf osConfig.optinpermanence.enable {
        "/persist/home/${config.home.username}/steam" = {
          directories = [
            {
              directory = ".local/share/Steam";
              method = "symlink";
            }
            ".config/Epic"
            ".config/r2modman"
            ".config/r2modmanPlus-local"
            ".config/unity3d"
            ".config/VA_11_Hall_A"
            ".local/share/Celeste"
            ".local/share/Terraria"
            ".local/share/applications"
            ".local/share/vulkan"
          ];
          allowOther = true;
        };
      };
    };
  };
}
