{
  lib,
  pkgs,
  config,
  ...
}:
{
  options = with lib; {
    theme = mkOption {
      type = types.str;
      default = "madotsuki";
      example = "kanagawa";
    };
  };
  config = {
    stylix = {
      enable = true;
      base16Scheme = ./../themes/${config.theme}/scheme.yaml;

      fonts = {
        monospace = {
          package = pkgs.cascadia-code;
          name = "Cascadia Code NF";
        };

        serif = {
          package = pkgs.cascadia-code;
          name = "Cascadia Mono NF";
        };

        sansSerif = config.stylix.fonts.serif;
        emoji = config.stylix.fonts.monospace;
        sizes = {
          terminal = 14;
        };
      };

      cursor = {
        package = pkgs.graphite-cursors;
        name = "Graphite";
        size = 16;
      };
      autoEnable = true;
      homeManagerIntegration.autoImport = false;
      homeManagerIntegration.followSystem = false;
    };
  };
}
