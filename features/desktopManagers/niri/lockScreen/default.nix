{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}:
{
  programs.hyprlock = with config.lib.stylix.colors; {
    enable = true;
    settings =
      let
        fonts = config.stylix.fonts;
      in
      lib.mkForce {
        # BACKGROUND
        background = [
          {
            path = "${osConfig.theme.image}";
            #color = $background
            blur_passes = 2;
            contrast = 1;
            brightness = 0.5;
            vibrancy = 0.2;
            vibrancy_darkness = 0.2;
          }
        ];

        # GENERAL
        general = [
          {
            no_fade_in = true;
            no_fade_out = true;
            hide_cursor = false;
            grace = 0;
            disable_loading_bar = true;
          }
        ];

        # INPUT FIELD
        input-field = [
          {
            size = "250, 60";
            outline_thickness = 2;
            dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
            dots_spacing = 0.35; # Scale of dots' absolute size, 0.0 - 1.0
            dots_center = true;
            fade_on_empty = false;
            rounding = 0;
            font_color = "rgb(${base05})";
            fail_color = "rgb(${base08})";
            inner_color = "rgb(${base00})";
            outer_color = "rgb(${base0A})";
            check_color = "rgb(${base01})";
            placeholder_text = ''<i><span foreground="##${base07}">Input Password...</span></i>'';
            hide_input = false;
            position = "0, -200";
            halign = "center";
            valign = "center";
          }
        ];

        label = [
          # DATE
          {
            text = ''cmd[update:1000] echo "$(date +"%A, %B %d")"'';
            color = "rgba(242, 243, 244, 0.75)";
            font_size = 22;
            font_family = fonts.monospace.name;
            position = "0, 300";
            halign = "center";
            valign = "center";
          }
          # TIME
          {
            text = ''cmd[update:1000] echo "$(date +"%-I:%M")"'';
            color = "rgba(242, 243, 244, 0.75)";
            font_size = 95;
            font_family = "${fonts.monospace.name} Bold";
            position = "0, 200";
            halign = "center";
            valign = "center";
          }
        ];

        # Profile Picture
        image = [
          {
            path = "/home/justin/Pictures/profile_pictures/justin_square.png";
            size = 100;
            border_size = 2;
            # border_color = $foreground
            position = "0, -100";
            halign = "center";
            valign = "center";
          }
          # Desktop Environment
          {
            path = "/home/justin/Pictures/profile_pictures/hypr.png";
            size = 75;
            border_size = 2;
            #border_color = $foreground;
            position = "-50, 50";
            halign = "right";
            valign = "bottom";
          }
        ];
      };
  };
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "${lib.getExe pkgs.hyprlock}";
        before_sleep_cmd = "${lib.getExe pkgs.hyprlock}";
      };

      listener = [
        {
          timeout = 300;
          on-timeout = "${lib.getExe pkgs.hyprlock}";
        }
        {
          timeout = 305;
          on-timeout = "${pkgs.niri}/bin/niri msg action power-off-monitors";
          on-resume = "${pkgs.niri}/bin/niri msg action power-on-monitors";
        }
      ];
    };
  };
}
