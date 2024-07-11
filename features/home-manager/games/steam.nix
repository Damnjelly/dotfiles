{
  lib,
  pkgs,
  config,
  ...
}:
{
  home = {
    packages = with pkgs; [
      runelite
      r2modman
    ];
    persistence = lib.mkIf config.optinpermanence.enable {
      "/persist/home/${config.home.username}/steam" = {
        directories = [
          {
            directory = ".local/share/Steam";
            method = "symlink";
          }
          ".local/share/Celeste"
          ".local/share/applications"
          ".config/r2modman"
          ".config/r2modmanPlus-local"
          ".config/unity3d"
        ];
        allowOther = true;
      };
    };
  };
}
