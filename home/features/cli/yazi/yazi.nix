{ pkgs, ... }:
let
  smart-enter-init = builtins.readFile ./yazi-smart-enter-init.lua;
  init = builtins.readFile ./yazi-init.lua;
  starship = builtins.readFile ./yazi-starship-init.lua;
in {
  home = {
    file.".config/yazi/plugins/smart-enter.yazi/init.lua".text =
      "${smart-enter-init}";
    file.".config/yazi/init.lua".text = "${init}";
    file.".config/yazi/plugins/starship.yazi/init.lua".text = "${starship}";
  };
  stylix.targets.yazi.enable = true;
  programs.yazi = {
    enable = true;
    package = pkgs.yazi;
    enableBashIntegration = true;

    keymap = {
      manager = {
        prepend_keymap = [
          {
            exec = "plugin --sync smart-enter";
            on = [ "<Enter>" ];
            desc = "Enter the child directory, or open the file";
          }
          {
            exec = "seek -5";
            on = [ "<C-Up>" ];
            desc = "Seek up 5 units in the preview";
          }
          {
            exec = "seek 5";
            on = [ "<C-Down>" ];
            desc = "Seek down 5 units in the preview";
          }
        ];
      };
    };

    settings = {
      headsup.disable_exec_warn = true;
      manager = {
        ratio = [ 1 4 6 ];
        sort_by = "extension";
      };

      preview = {
        tab_size = 2;
        max_width = 500;
        max_height = 400;
        cache_dir = "";
        image_filter = "triangle";
        image_quality = 75;
        sixel_fraction = 15;
        ueberzug_scale = 2;
        ueberzug_offset = [ 0 0 0 0 ];
      };

      opener = {
        edit = [{
          exec = ''nvim "$@"'';
          desc = "nvim";
          block = true;
          for = "unix";
        }];
        open = [{
          exec = ''xdg-open "$@"'';
          desc = "Open";
          for = "linux";
        }];
        reveal = [{
          exec = ''exiftool "$1"; echo "Press enter to exit"; read _'';
          block = true;
          desc = "Show EXIF";
          for = "unix";
        }];
        extract = [{
          exec = ''unar "$1"'';
          desc = "Extract here";
          for = "unix";
        }];
        play = [
          {
            exec = ''mpv "$@"'';
            orphan = true;
            for = "unix";
          }
          {
            exec = ''mediainfo "$1"; echo "Press enter to exit"; read _'';
            block = true;
            desc = "Show media info";
            for = "unix";
          }
        ];
        viewPdf = [{
          exec = ''zathura "$@"'';
          desc = "View with pdf viewer";
          for = "unix";
        }];
      };

      open = {
        rules = [
          {
            name = "*/";
            use = [ "edit" "open" "reveal" ];
          }
          {
            mime = "text/*";
            use = [ "edit" "reveal" ];
          }
          {
            mime = "image/*";
            use = [ "open" "reveal" ];
          }
          {
            mime = "video/*";
            use = [ "play" "reveal" ];
          }
          {
            mime = "audio/*";
            use = [ "play" "reveal" ];
          }
          {
            mime = "inode/x-empty";
            use = [ "edit" "reveal" ];
          }
          {
            mime = "application/json";
            use = [ "edit" "reveal" ];
          }
          {
            mime = "*/javascript";
            use = [ "edit" "reveal" ];
          }
          {
            mime = "application/pdf";
            use = [ "viewPdf" ];
          }

          # Archives
          {
            mime = "application/zip";
            use = [ "extract" "reveal" ];
          }
          {
            mime = "application/gzip";
            use = [ "extract" "reveal" ];
          }
          {
            mime = "application/x-tar";
            use = [ "extract" "reveal" ];
          }
          {
            mime = "application/x-bzip";
            use = [ "extract" "reveal" ];
          }
          {
            mime = "application/x-bzip2";
            use = [ "extract" "reveal" ];
          }
          {
            mime = "application/x-7z-compressed";
            use = [ "extract" "reveal" ];
          }
          {
            mime = "application/x-rar";
            use = [ "extract" "reveal" ];
          }
          {
            mime = "application/xz";
            use = [ "extract" "reveal" ];
          }
          # Other
          {
            mime = "*";
            use = [ "open" "reveal" ];
          }
        ];
      };
    };
  };
}
