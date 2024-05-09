{ pkgs, config, ... }:
let
  wallpaper = pkgs.writeShellScriptBin "wallpaper.sh" ''
    swww-daemon &
    ${pkgs.swww}/bin/swww img ${config.stylix.image} &
  '';
in {
  config = {
    programs.niri = {
      enable = true;
      package = pkgs.niri-unstable;
      settings = {
        prefer-no-csd = true;
        hotkey-overlay.skip-at-startup = true;
        spawn-at-startup = [
          { command = [ "${wallpaper}/bin/wallpaper.sh" ]; }
          { command = [ "${pkgs.waybar}/bin/waybar" ]; }
        ];

        #TODO: fix
        window-rules = [{
          matches = [{ title = "Vesktop"; }];
          open-on-output = "HDMI-A-1";
          open-maximized = true;
        }];

        binds = with config.lib.niri.actions;
          let sh = spawn "sh" "-c";
          in {
            # Open applications
            "Mod+W".action = sh "${pkgs.foot}/bin/foot sunbeam";
            "Mod+Q".action =
              sh "${pkgs.foot}/bin/foot ${pkgs.zellij}/bin/zellij -l welcome";

            # Actions
            "Mod+C".action = close-window;
            "Mod+D".action = center-column;
            "Mod+S".action = maximize-column;
            "Mod+A".action = fullscreen-window;

            "Ctrl+Alt+S".action = screenshot-screen;
            "Shift+Alt+S".action = screenshot;

            "Mod+P".action = sh "${pkgs.hyprpicker}/bin/hyprpicker -a";

            # Movement
            "Mod+Left".action = focus-column-left;
            "Mod+Down".action = focus-window-down;
            "Mod+Up".action = focus-window-up;
            "Mod+Right".action = focus-column-right;
            "Mod+H".action = focus-column-left;
            "Mod+J".action = focus-window-down;
            "Mod+K".action = focus-window-up;
            "Mod+L".action = focus-column-right;

            "Mod+Alt+Left".action = move-column-left;
            "Mod+Alt+Down".action = consume-window-into-column;
            "Mod+Alt+Up".action = expel-window-from-column;
            "Mod+Alt+Right".action = move-column-right;
            "Mod+Alt+H".action = move-column-left;
            "Mod+Alt+J".action = consume-window-into-column;
            "Mod+Alt+K".action = expel-window-from-column;
            "Mod+Alt+L".action = move-column-right;

            "Mod+Alt+Ctrl+Left".action = move-column-to-monitor-left;
            "Mod+Alt+Ctrl+Down".action = move-column-to-monitor-down;
            "Mod+Alt+Ctrl+Up".action = move-column-to-monitor-up;
            "Mod+Alt+Ctrl+Right".action = move-column-to-monitor-right;
            "Mod+Alt+Ctrl+H".action = move-column-to-monitor-left;
            "Mod+Alt+Ctrl+J".action = move-column-to-monitor-down;
            "Mod+Alt+Ctrl+K".action = move-column-to-monitor-up;
            "Mod+Alt+Ctrl+L".action = move-column-to-monitor-right;

            "Mod+M".action = set-column-width "+10%";
            "Mod+N".action = set-column-width "-10%";
            "Mod+Alt+M".action = set-window-height "+10%";
            "Mod+Alt+N".action = set-window-height "-10%";
          };

        layout = with config.lib.stylix.colors; {
          gaps = 12;
          default-column-width = { proportion = 0.5; };
          focus-ring.enable = false;
          border = {
            enable = true;
            width = 2;
            active.gradient = {
              angle = 45;
              from = "#${base08}";
              to = "#${base07}";
            };
            inactive.color = "#${base04}";
          };
          struts = {
            left = 32;
            right = 32;
            bottom = 32;
          };
        };

        outputs."DP-1" = {
          mode = {
            width = 2560;
            height = 1440;
            refresh = 164.847;
          };
          position = {
            x = 0;
            y = 0;
          };
        };
        outputs."DP-2" = {
          mode = {
            width = 2560;
            height = 1440;
            refresh = 74.78;
          };
          position = {
            x = 2560;
            y = 0;
          };
        };
        outputs."HDMI-A-1" = {
          mode = {
            width = 1920;
            height = 1080;
            refresh = 60.0;
          };
          position = {
            x = 300;
            y = 1440;
          };
        };
      };
    };
  };
}
