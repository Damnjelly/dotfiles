{ pkgs, config, lib, ... }: {
  options = with lib; {
    theme = mkOption {
      type = lib.types.str;
      default = "madotsuki";
      example = "kanagawa";
    };
  };
  config = {
    home.file.".config/wpaperd/wallpapers/" = {
      source = ./${config.theme}/wallpapers;
      recursive = true;
    };
    programs.wpaperd.enable = true;
    stylix = {
      image = ./${config.theme}/wallpapers/wallpaper.png;
      base16Scheme = ./${config.theme}/scheme.yaml;

      fonts = {
        monospace = {
          package = pkgs.hack-font;
          name = "Hack";
        };

        serif = config.stylix.fonts.monospace;
        sansSerif = config.stylix.fonts.monospace;
        emoji = config.stylix.fonts.monospace;
        sizes = { terminal = 14; };
      };

      cursor = {
        package = pkgs.hackneyed;
        name = "Hackneyed";
        size = 16;
      };
    };
  };
}
