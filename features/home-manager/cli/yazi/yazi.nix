{ lib, config, ... }:
{
  xdg.configFile."yazi/init.lua".text =
    lib.mkIf config.programs.yazi.enable # lua
      '''';
  stylix.targets.yazi.enable = true;
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;

    keymap = {
      manager = {
        prepend_keymap = [
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
          {
            exec = "seek -5";
            on = [ "<C-k>" ];
            desc = "Seek up 5 units in the preview";
          }
          {
            exec = "seek 5";
            on = [ "<C-j>" ];
            desc = "Seek down 5 units in the preview";
          }
        ];
      };
    };

    settings = {
      headsup.disable_exec_warn = true;
      manager = {
        ratio = [
          1
          4
          6
        ];
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
        ueberzug_offset = [
          0
          0
          0
          0
        ];
      };

      opener = {
        edit = [
          {
            exec = ''$EDITOR "$@"'';
            desc = "Text edit";
            block = true;
            for = "unix";
          }
        ];
        open = [
          {
            exec = ''xdg-open "$@"'';
            desc = "Open";
            for = "linux";
          }
        ];
        reveal = [
          {
            exec = ''exiftool "$1"; echo "Press enter to exit"; read _'';
            block = true;
            desc = "Show EXIF";
            for = "unix";
          }
        ];
        extract = [
          {
            exec = ''unar "$1"'';
            desc = "Extract here";
            for = "unix";
          }
        ];
        play = [
          {
            exec = ''$MUSIC "$@"'';
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
        viewPdf = [
          {
            exec = ''zathura "$@"'';
            desc = "View with pdf viewer";
            for = "unix";
          }
        ];
      };

      open = {
        rules = [
          {
            name = "*/";
            use = [
              "edit"
              "open"
              "reveal"
              "play"
            ];
          }
          {
            mime = "text/*";
            use = [
              "edit"
              "reveal"
            ];
          }
          {
            mime = "image/*";
            use = [
              "open"
              "reveal"
            ];
          }
          {
            mime = "video/*";
            use = [
              "play"
              "reveal"
            ];
          }
          {
            mime = "audio/*";
            use = [
              "play"
              "reveal"
            ];
          }
          {
            mime = "inode/x-empty";
            use = [
              "edit"
              "reveal"
            ];
          }
          {
            mime = "application/json";
            use = [
              "edit"
              "reveal"
            ];
          }
          {
            mime = "*/javascript";
            use = [
              "edit"
              "reveal"
            ];
          }
          {
            mime = "application/pdf";
            use = [ "viewPdf" ];
          }

          # Archives
          {
            mime = "application/zip";
            use = [
              "extract"
              "reveal"
            ];
          }
          {
            mime = "application/gzip";
            use = [
              "extract"
              "reveal"
            ];
          }
          {
            mime = "application/x-tar";
            use = [
              "extract"
              "reveal"
            ];
          }
          {
            mime = "application/x-bzip";
            use = [
              "extract"
              "reveal"
            ];
          }
          {
            mime = "application/x-bzip2";
            use = [
              "extract"
              "reveal"
            ];
          }
          {
            mime = "application/x-7z-compressed";
            use = [
              "extract"
              "reveal"
            ];
          }
          {
            mime = "application/x-rar";
            use = [
              "extract"
              "reveal"
            ];
          }
          {
            mime = "application/xz";
            use = [
              "extract"
              "reveal"
            ];
          }
          # Other
          {
            mime = "*";
            use = [
              "open"
              "reveal"
            ];
          }
        ];
      };
    };
  };
}
