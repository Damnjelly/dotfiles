{
  config,
  pkgs,
  ...
}: {
  programs.kitty = {
    enable = true;
    package = pkgs.kitty;
    font.name = "${config.stylix.fonts.monospace.name}";

    keybindings = {
      "ctrl+v" = "paste_from_clipboard";
      "ctrl+c" = "copy_and_clear_or_interrupt";
    };

    settings = with config.lib.stylix.colors; {
      # The basic colors
      foreground = "#${base05}";
      background = "#${base00}";
      selection_foreground = "#${base00}";
      selection_background = "#${base06}";

      # Cursor colors
      cursor = "#${base06}";
      cursor_text_color = "#${base00}";

      # URL underline color when hovering with mouse
      url_color = "#${base06}";

      # Kitty window border colors
      active_border_color = "#${base07}";
      inactive_border_color = "#${base04}";
      bell_border_color = "#${base0A}";

      # Tab bar colors
      active_tab_foreground = "#${base00}";
      active_tab_background = "#${base01}";
      inactive_tab_foreground = "#${base05}";
      inactive_tab_background = "#${base04}";
      tab_bar_background = "#${base03}";

      # Colors for marks (marked text in the terminal)
      mark1_foreground = "#${base00}";
      mark1_background = "#${base07}";
      mark2_foreground = "#${base00}";
      mark2_background = "#${base0E}";
      mark3_foreground = "#${base00}";
      mark3_background = "#${base0C}";

      # Add padding
      window_padding_width = 2;

      # The 16 terminal colors
      # Black
      color0 = "#5C5F77";
      color8 = "#6C6F85";

      # Red
      color1 = "#${base09}";
      color9 = "#${base09}";

      # Green
      color2 = "#${base0B}";
      color10 = "#${base0B}";

      # Yellow
      color3 = "#${base0A}";
      color11 = "#${base0A}";

      # Blue
      color4 = "#${base0D}";
      color12 = "#${base0D}";

      # Magenta
      color5 = "#${base07}";
      color13 = "#${base07}";

      # Cyan
      color6 = "#${base0C}";
      color14 = "#${base0C}";

      # White
      color7 = "#${base04}";
      color15 = "#${base03}";
    };
  };
}
