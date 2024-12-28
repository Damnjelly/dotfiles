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
          package = pkgs.rbw.overrideAttrs (_: {
            src = pkgs.fetchFromGitHub {
              owner = "davla";
              repo = "rbw";
              rev = "fix/client-name-header";
              sha256 = "sha256-Sgs+qjKdtS5i7zF86TLSZMVKTDoeYhIgKEwjUUXw/cc=";
            };
            cargoDeps = pkgs.rustPlatform.importCargoLock {
              lockFile = (
                pkgs.fetchurl {
                  url = "https://raw.githubusercontent.com/davla/rbw/dd6b65427de3a4b38d27350d8ad7ebacb29e97ff/Cargo.lock";
                  hash = "sha256-bAELLBb0x0BOGPMLBRX/s0qxqN8XOxUW9OUa55WjeaA=";
                }
              );
              allowBuiltinFetchGit = true;
            };
          });
          settings = {
            email = "juinen@proton.me";
            lock_timeout = 90000;
            pinentry = pkgs.pinentry-rofi;
          };
        };
        programs.rofi = {
          enable = true;
          terminal = "${pkgs.foot}/bin/foot";
          package = pkgs.unstable.rofi-wayland;
          #plugins = with pkgs; [ (rofi-calc.override { rofi-unwrapped = rofi-wayland-unwrapped; }) ];
          extraConfig = {
            modes = "drun,window,ssh,combi,run,power:rofi-power-menu";
          };
          font = lib.mkForce "scientifica 16";
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
                  padding:    6px;
                  background-color:   @bg0;

                  border:             1px;
                  border-color:       ${base0D};
                }

                inputbar {
                  spacing:    6px; 
                  padding:    6px;

                  background-color:   @bg1;
                }

                prompt, entry, element-icon, element-text {
                  vertical-align: 0.5;
                }

                prompt {
                  text-color: @accent-color;
                }

                textbox {
                  padding:            6px;
                  background-color:   @bg1;
                }

                listview {
                  padding:    2px 0;
                  lines:      8;
                  columns:    1;

                  fixed-height:   false;
                }

                element {
                  padding:    6px;
                  spacing:    6px;
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
