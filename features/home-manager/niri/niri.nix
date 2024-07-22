{ pkgs, config, ... }:
{
  config = {
    programs.niri = {
      enable = true;
      package = pkgs.niri-unstable;
      settings = {
        prefer-no-csd = true;
        hotkey-overlay.skip-at-startup = true;
        environment.DISPLAY = ":0";
        spawn-at-startup = [
          { command = [ "${pkgs.wpaperd}/bin/wpaperd" ]; }
          { command = [ "${pkgs.xwayland-satellite}/bin/xwayland-satellite" ]; }
        ];

        window-rules = [
          {
            draw-border-with-background = false;
            geometry-corner-radius =
              let
                r = 0.0;
              in
              {
                top-left = r;
                top-right = r;
                bottom-left = r;
                bottom-right = r;
              };
            clip-to-geometry = true;
          }
          {
            matches = [ { app-id = "^vesktop$"; } ];
            open-on-output = "HDMI-A-1";
            open-fullscreen = true;
          }
          (
            let
              w = 1803;
              h = 1006;
            in
            {
              matches = [ { app-id = "^net-runelite-client-RuneLite$"; } ];
              default-column-width.fixed = w;
              min-width = w;
              max-height = h;
              min-height = h;
            }
          )
          (
            let
              w = 200;
              h = 300;
            in
            {
              matches = [ { app-id = "^net-runelite-launcher-Launcher$"; } ];
              default-column-width.fixed = w;
              min-width = w;
              max-height = h;
              min-height = h;
            }
          )
          (
            let
              w = 35.0;
              h = 800;
            in
            {
              matches = [ { title = "^Sunbeam$"; } ];
              default-column-width.proportion = w;
              max-height = h;
              min-height = h;
            }
          )
        ];

        binds =
          with config.lib.niri.actions;
          let
            sh = spawn "sh" "-c";
          in
          {
            # Open applications
            "Mod+W".action = sh "${pkgs.rofi-wayland}/bin/rofi -show combi -combi-modes 'window,drun,ssh,power' -show-icons";
            "Mod+P".action = sh "${pkgs.rofi-rbw-wayland}/bin/rofi-rbw";
            "Mod+Q".action = sh "${pkgs.foot}/bin/foot ${pkgs.zellij}/bin/zellij -l welcome";

            # Actions
            "Mod+C".action = close-window; 
            "Mod+D".action = center-column;
            "Mod+S".action = maximize-column;
            "Mod+A".action = fullscreen-window;

            "Ctrl+Alt+S".action = screenshot-screen;
            "Shift+Alt+S".action = screenshot;
            "Shift+Alt+P".action = sh "${pkgs.hyprpicker}/bin/hyprpicker -a";

            "Mod+Y".action = sh "systemctl suspend";

            # Movement
            "Mod+Left".action = focus-column-or-monitor-left;
            "Mod+Down".action = focus-window-down;
            "Mod+Up".action = focus-window-up;
            "Mod+Right".action = focus-column-or-monitor-right;
            "Mod+H".action = focus-column-or-monitor-left;
            "Mod+J".action = focus-window-down;
            "Mod+K".action = focus-window-up;
            "Mod+L".action = focus-column-or-monitor-right;

            "Mod+Shift+Left".action = focus-monitor-left;
            "Mod+Shift+Down".action = focus-monitor-down;
            "Mod+Shift+Up".action = focus-monitor-up;
            "Mod+Shift+Right".action = focus-monitor-right;
            "Mod+Shift+H".action = focus-monitor-left;
            "Mod+Shift+J".action = focus-monitor-down;
            "Mod+Shift+K".action = focus-monitor-up;
            "Mod+Shift+L".action = focus-monitor-right;

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
          default-column-width = {
            proportion = 0.5;
          };
          focus-ring.enable = false;
          border = {
            enable = true;
            width = 1;
            active.color = "#${base07}";
            # active.gradient = {
            #   angle = 45;
            #   from = "#${base08}";
            #   to = "#${base07}";
            # };
            inactive.color = "#${base04}00";
          };
          struts = {
            left = 48;
            right = 48;
            top = 24;
            bottom = 24;
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
