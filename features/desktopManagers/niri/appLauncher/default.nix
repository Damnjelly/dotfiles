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
        home.packages = with pkgs; [
          rofi-power-menu
          rofi-rbw-wayland
        ];
        programs.rbw = {
          enable = true;
          settings = {
            email = "juinen@proton.me";
            lock_timeout = 90000;
            pinentry = pkgs.pinentry-rofi;
          };
        };
        programs.rofi = {
          enable = true;
          terminal = "${pkgs.foot}/bin/foot";
          package = pkgs.rofi-wayland;
          #plugins = with pkgs; [ (rofi-calc.override { rofi-unwrapped = rofi-wayland-unwrapped; }) ];
          extraConfig = {
            modes = "drun,window,ssh,combi,run,power:rofi-power-menu";
          };
          font = lib.mkForce "${config.stylix.fonts.monospace.name} SemiBold 12";
          theme =
            with config.lib.stylix.colors.withHashtag;
            lib.mkForce "${pkgs.writeText "theme.rasi" # rasi
              ''
                /*******************************************************************************
                * ROFI SQUARED THEME EDITED FOR STYLIX 
                * User                 : LR-Tech               
                * Theme Repo           : https://github.com/lr-tech/rofi-themes-collection
                *******************************************************************************/

                * {
                  bg0:     ${base00};
                  bg1:     ${base03};
                  fg0:     ${base05};

                  accent-color:     ${base07};
                  urgent-color:     ${base08};

                  background-color:   transparent;
                  text-color:         @fg0;

                  margin:     0;
                  padding:    0;
                  spacing:    0;
                }

                window {
                  location:   center;
                  width:      880;
                  padding:    24px;
                  background-color:   @bg0;
                }

                mainbox {
                  padding:    8px;
                  background-color:   @bg0;

                  border:             1px;
                  border-color:       ${base0D};
                }

                inputbar {
                  spacing:    8px; 
                  padding:    8px;

                  background-color:   @bg1;
                }

                prompt, entry, element-icon, element-text {
                  vertical-align: 0.5;
                }

                prompt {
                  text-color: @accent-color;
                }

                textbox {
                  padding:            8px;
                  background-color:   @bg1;
                }

                listview {
                  padding:    4px 0;
                  lines:      8;
                  columns:    1;

                  fixed-height:   false;
                }

                element {
                  padding:    8px;
                  spacing:    8px;
                }

                element normal normal {
                  text-color: @fg0;
                }

                element normal urgent {
                  text-color: @urgent-color;
                }

                element normal active {
                  text-color: @accent-color;
                }

                element alternate active {
                  text-color: @accent-color;
                }

                element selected {
                  text-color: @bg0;
                }

                element selected normal, element selected active {
                  background-color:   @accent-color;
                }

                element selected urgent {
                  background-color:   @urgent-color;
                }

                element-icon {
                  size:   0.8em;
                }

                element-text {
                  text-color: inherit;
                }
              ''
            }";
        };
      };
}
