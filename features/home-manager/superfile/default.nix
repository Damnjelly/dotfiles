{ outputs, pkgs, ... }:
{
  imports = [ outputs.homeManagerModules.superfile ];
  #stylix.targets.superfile.enable = true;
  programs.superfile = {
    enable = true;
    package = pkgs.geleisuperfile;
    settings = {
      metadata = true;
      cd_on_quit = true;
      auto_check_update = true;
      file_preview_width = 3;
    };

    hotkeys = {
      #globals
      quit = [ "esc" "" ];

      list_up = [ "k" "" ];
      list_down = [ "j" "" ];

      pinned_directory = [ "p" "" ];
      close_file_panel = [ "N" "" ];
      create_new_file_panel = [ "n" "" ];
      
      next_file_panel = [ "L" "" ];
      previous_file_panel = [ "H" "" ];
      focus_on_process_bar = [ "P" "" ];
      focus_on_sidebar = [ "B" "" ];
      focus_on_metadata = [ "M" "" ];

      change_panel_mode = [ "v" "" ];
      open_help_menu = [ "?" "" ];

      file_panel_directory_create = ["A" "" ];
      file_panel_file_create = ["a" "" ];
      file_panel_item_rename = ["r" "" ];
      paste_item = ["p" "" ];
      extract_file = ["z" "" ];
      compress_file = ["Z" "" ];
      toggle_dot_file = [ "." "" ];

      oepn_file_with_editor = ["e" "" ];
      open_current_directory_with_editor = ["E" "" ];

      cancel = [ "backspace" "q" ];
      confirm = ["enter" "l" ];

      # normal mode
      delete_item = [ "d" "" ];
      select_item = [ "enter" "l" ];
      parent_directory = [ "backspace" "h" ];
      copy_single_item = [ "y" "" ];
      cut_single_item = [ "x" "" ];
      search_bar = [ "/" "" ];
      command_line = [":" "" ];

      # select mode
      file_panel_select_mode_item_single_select = [ "enter" "l" ];
      file_panel_select_mode_item_select_down = [ "shift+down" "J" ];
      file_panel_select_mode_item_select_up = [ "shift+up" "K" ];
      file_panel_select_mode_item_delete = [ "delete" "d" ];
      file_panel_select_mode_item_copy = [ "y" "" ];
      file_panel_select_mode_item_cut = [ "x" "" ];
      file_panel_select_all_item = [ "A" "" ];
    };
  };
}
