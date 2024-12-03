{
  lib,
  pkgs,
  config,
  ...
}:
{
  options = with lib; {
    theme = {
      name = mkOption {
        type = types.str;
        default = "default-dark";
        example = "madotsuki";
      };
      path = mkOption {
        type = types.enum [
          "online"
          "local"
        ];
        default = "online";
      };
      alpha = mkOption {
        type = with types; listOf str;
        default = [
          "███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗"
          "████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║"
          "██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║"
          "██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║"
          "██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║"
          "╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝"
        ];
      };
      fastfetch = mkOption {
        type = types.path;
        default = null;
      };
      image = mkOption {
        type = types.path;
        default = ./wallpaper.png;
      };
    };
  };

  imports = [
    ./madotsuki
  ];

  config =
    let
      scheme =
        if (config.theme.path == "online") then
          { base16Scheme = config.theme.name; }
        else
          { base16Scheme = ./${config.theme.name}/assets/scheme.yaml; };
    in
    {
      stylix = {
        enable = true;

        image = config.theme.image;

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
            terminal = 12;
          };
        };

        cursor = {
          package = pkgs.graphite-cursors;
          name = "graphite-light";
          size = 12;
        };
        autoEnable = true;
        homeManagerIntegration = {
          autoImport = true;
          followSystem = true;
        };
      } // scheme;
    };
}
