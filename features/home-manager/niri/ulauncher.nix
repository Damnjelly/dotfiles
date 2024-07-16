{
  pkgs,
  lib,
  config,
  ...
}:
{
  home = {
    packages = with pkgs; [ ulauncher ];

    persistence = lib.mkIf config.optinpermanence.enable {
      "/persist/home/${config.home.username}/ulauncher" = {
        directories = [
          ".cache/ulauncher"
          ".cache/ulauncher-cache"
          ".config/ulauncher"
          ".local/share/ulauncher"
        ];
        allowOther = true;
      };
    };
  };
  xdg =
    let
      themename = "stylix";
    in
    {
      configFile."ulauncher/user-themes/${themename}/theme.css".text =
        with config.lib.stylix.colors.withHashtag; # css
        ''
          /**
           * App Window
           */
          @define-color bg_color ${base00};
          @define-color window_bg @bg_color;
          @define-color window_border_color ${base07};
          @define-color prefs_backgroud ${base00};

          /**
           * Input
           */
          @define-color selected_bg_color ${base08};
          @define-color selected_fg_color ${base05};
          @define-color input_color ${base05};
          @define-color caret_color ${base08};

          /**
           * Result items
           */
          @define-color item_name ${base04};
          @define-color item_text ${base04};
          @define-color item_box_selected ${base02};
          @define-color item_text_selected ${base07};
          @define-color item_name_selected ${base06};
          @define-color item_shortcut_color ${base04};
          @define-color item_shortcut_color_sel ${base06};

          .app {
              background-color: @window_bg;
              border-color: @window_border_color;
              border-width: 2px;
              border-radius: 12px;
          }

          .input {
              color: @input_color;
          }

          /**
           * Selected text in input
           */
          .input *:selected,
          .input *:focus,
          *:selected:focus {
              background-color: alpha (@selected_bg_color, 0.9);
              color: @selected_fg_color;
          }

          .item-text {
              color: @item_text;
          }
          .item-name {
              color: @item_name;
          }

          .selected.item-box {
              background-color: @item_box_selected;
              border-left: 2px solid @window_border_color;
              border-right: 2px solid @window_border_color;
              border-radius: 12px;
          }
          .selected.item-box .item-text {
              color: @item_text_selected;
          }
          .selected.item-box .item-name {
              color: @item_name_selected;
          }
          .item-shortcut {
              color: @item_shortcut_color;
          }
          .selected.item-box .item-shortcut {
              color: @item_shortcut_color_sel;
          }

          .prefs-btn {
              opacity: 0.8;
          }
          .prefs-btn:hover {
              background-color: @prefs_backgroud;
          }

          .no-window-shadow {
              margin: -20px;
          }
        '';

      configFile."ulauncher/user-themes/${themename}/theme-gtk-3.20.css".text = # css
        ''
          @import url("theme.css");

          .input {
              caret-color: @caret_color;
          }
          .selected.item-box {
              /* workaround for a bug in GTK+ < 3.20 */
              border: none;
          }
        '';
      configFile."ulauncher/user-themes/${themename}/manifest.json".text =
        with config.lib.stylix.colors.withHashtag; # json
        ''
          {
            "manifest_version": "1",
            "name": "${themename}",
            "display_name": "${themename}",
            "extend_theme": "dark",
            "css_file": "theme.css",
            "css_file_gtk_3.20+": "theme-gtk-3.20.css",
            "matched_text_hl_colors": {
              "when_selected": "${base03}",
              "when_not_selected": "${base03}"
            }
          }
        '';
    };
}
