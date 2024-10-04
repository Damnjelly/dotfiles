{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}:
{
  config =
    lib.mkIf (builtins.elem config.home.username osConfig.features.desktopManagers.niri.enableFor)
      {
        # add the home manager module
        programs.ags = {
          enable = true;

          # null or path, leave as null if you don't want hm to manage the config
          #configDir = ./ags;

          # additional packages to add to gjs's runtime
          extraPackages = with pkgs; [
            gtksourceview
            webkitgtk
            accountsservice
            bluetuith
          ];
        };
        home.persistence = lib.mkIf osConfig.optinpermanence.enable {
          "/persist/home/${config.home.username}/ags" = {
            directories = [ ".config/ags" ];
            allowOther = true;
          };
        };
      };
}
