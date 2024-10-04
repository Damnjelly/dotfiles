{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.programs.superfile;
  tomlFormat = pkgs.formats.toml { };
in
{
  options = {
    programs.superfile = {
      enable = mkEnableOption "superfile";

      package = mkOption {
        type = types.package;
        default = pkgs.superfile;
        defaultText = literalExpression "pkgs.superfile";
        description = "The Superfile package to install";
      };

      theme = mkOption {
        description = ''Set of themes, possible options are listed on https://superfile.netlify.app/configure/custom-theme/'';
        default = {
          catppuccin = {
            code_syntax_highlight = "catppuccin-mocha";

            file_panel_border = "#6c7086";
            sidebar_border = "#1e1e2e";
            footer_border = "#6c7086";

            file_panel_border_active = "#b4befe";
            sidebar_border_active = "#f38ba8";
            footer_border_active = "#a6e3a1";
            modal_border_active = "#868686";

            full_screen_bg = "#1e1e2e";
            file_panel_bg = "#1e1e2e";
            sidebar_bg = "#1e1e2e";
            footer_bg = "#1e1e2e";
            modal_bg = "#1e1e2e";

            full_screen_fg = "#a6adc8";
            file_panel_fg = "#a6adc8";
            sidebar_fg = "#a6adc8";
            footer_fg = "#a6adc8";
            modal_fg = "#a6adc8";

            cursor = "#f5e0dc";
            correct = "#a6e3a1";
            error = "#f38ba8";
            hint = "#73c7ec";
            cancel = "#eba0ac";
            gradient_color = [
              "#89b4fa"
              "#cba6f7"
            ];

            file_panel_top_directory_icon = "#a6e3a1";
            file_panel_top_path = "#89b5fa";
            file_panel_item_selected_fg = "#98D0FD";
            file_panel_item_selected_bg = "#1e1e2e";

            sidebar_title = "#74c7ec";
            sidebar_item_selected_fg = "#A6DBF7";
            sidebar_item_selected_bg = "#1e1e2e";
            sidebar_divider = "#868686";

            modal_cancel_fg = "#383838";
            modal_cancel_bg = "#eba0ac";

            modal_confirm_fg = "#383838";
            modal_confirm_bg = "#89dceb";

            help_menu_hotkey = "#89dceb";
            help_menu_title = "#eba0ac";
          };
        };
        type = types.attrsOf tomlFormat.type;
        example = literalExpression '''';
      };

      settings = mkOption {
        type = tomlFormat.type;
        default = { };
        example = literalExpression '''';
      };

      hotkeys = mkOption {
        type = tomlFormat.type;
        default = {
          quit = [
            "esc"
            "q"
          ];
          list_up = [
            "up"
            "k"
          ];
          list_down = [
            "down"
            "j"
          ];
          pinned_directory = [
            "ctrl+p"
            ""
          ];
          close_file_panel = [
            "ctrl+w"
            ""
          ];
          create_new_file_panel = [
            "ctrl+n"
            ""
          ];
          next_file_panel = [
            "tab"
            "L"
          ];
          previous_file_panel = [
            "shift+left"
            "H"
          ];
          focus_on_process_bar = [
            "p"
            ""
          ];
          focus_on_side_bar = [
            "b"
            ""
          ];
          focus_on_metadata = [
            "m"
            ""
          ];
          change_panel_mode = [
            "v"
            ""
          ];
          open_help_menu = [
            "?"
            ""
          ];
          file_panel_directory_create = [
            "f"
            ""
          ];
          file_panel_file_create = [
            "c"
            ""
          ];
          file_panel_item_rename = [
            "r"
            ""
          ];
          paste_item = [
            "ctrl+v"
            ""
          ];
          extract_file = [
            "ctrl+e"
            ""
          ];
          compress_file = [
            "ctrl+r"
            ""
          ];
          toggle_dot_file = [
            "ctrl+h"
            ""
          ];
          oepn_file_with_editor = [
            "e"
            ""
          ];
          open_current_directory_with_editor = [
            "E"
            ""
          ];
          cancel = [
            "ctrl+c"
            "esc"
          ];
          confirm = [
            "enter"
            ""
          ];
          delete_item = [
            "ctrl+d"
            ""
          ];
          select_item = [
            "enter"
            "l"
          ];
          parent_directory = [
            "h"
            "backspace"
          ];
          copy_single_item = [
            "ctrl+c"
            ""
          ];
          cut_single_item = [
            "ctrl+x"
            ""
          ];
          search_bar = [
            "ctrl+f"
            ""
          ];
          command_line = [
            "/"
            ""
          ];
          file_panel_select_mode_item_single_select = [
            "enter"
            "l"
          ];
          file_panel_select_mode_item_select_down = [
            "shift+down"
            "J"
          ];
          file_panel_select_mode_item_select_up = [
            "shift+up"
            "K"
          ];
          file_panel_select_mode_item_delete = [
            "ctrl+d"
            "delete"
          ];
          file_panel_select_mode_item_copy = [
            "ctrl+c"
            ""
          ];
          file_panel_select_mode_item_cut = [
            "ctrl+x"
            ""
          ];
          file_panel_select_all_item = [
            "ctrl+a"
            ""
          ];
        };
        example = literalExpression '''';
      };
    };
  };
  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    xdg.configFile =
      let
        settings = {
          "superfile/HMInit/config.toml" = mkIf (cfg.settings != { }) {
            source = tomlFormat.generate "config.toml" cfg.settings;
            onChange = ''
              cp ${config.xdg.configHome}/superfile/HMInit/config.toml ${config.xdg.configHome}/superfile/config.toml 
              chmod u+w ${config.xdg.configHome}/superfile/config.toml
            '';
          };

          "superfile/HMInit/hotkeys.toml" = mkIf (cfg.hotkeys != { }) {
            source = tomlFormat.generate "hotkeys.toml" cfg.hotkeys;
            onChange = ''
              cp ${config.xdg.configHome}/superfile/HMInit/hotkeys.toml ${config.xdg.configHome}/superfile/hotkeys.toml 
              chmod u+w ${config.xdg.configHome}/superfile/hotkeys.toml
            '';
          };
        };

        themes = (
          mapAttrs' (
            n: v: nameValuePair "superfile/theme/${n}.toml" { source = tomlFormat.generate "${n}" v; }
          ) cfg.theme
        );
      in
      settings // themes;
  };
}
