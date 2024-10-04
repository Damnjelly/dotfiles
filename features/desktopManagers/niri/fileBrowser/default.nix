{
  lib,
  config,
  osConfig,
  pkgs,
  ...
}:
{
  imports = [
    ./plugins/glow.nix
    ./plugins/exifaudio.nix
    ./plugins/smart-enter.nix
    ./plugins/starship.nix
    ./plugins/yatline.nix
  ];
  config =
    lib.mkIf (builtins.elem config.home.username osConfig.features.desktopManagers.niri.enableFor)
      {
        home.packages = with pkgs; [
          exiftool # read, write, edit EXIF meta info
          ffmpegthumbnailer # video thumbnailer
          mediainfo # info about a video or audio file
          mpv # media player
          unar # archiver
        ];
        xdg = {
          configFile."yazi/init.lua".text =
            lib.mkIf config.programs.yazi.enable # lua
              '''';
          mimeApps = {
            enable = true;
            defaultApplications = {
              "inode/directory" = [ "yazi.desktop" ];
            };
          };
        };
        programs.yazi = {
          enable = true;
          enableFishIntegration = true;

          keymap = {
            manager = {
              prepend_keymap = [
                {
                  run = "cd /";
                  on = [
                    "g"
                    "r"
                  ];
                  desc = "Go to root";
                }
                {
                  run = "cd /etc/nixos";
                  on = [
                    "g"
                    "n"
                  ];
                  desc = "Go to the nixos configuration directory";
                }
                {
                  run = "cd /smb/";
                  on = [
                    "g"
                    "s"
                  ];
                  desc = "Go to the smb shares";
                }
                {
                  run = "cd /hdd/";
                  on = [
                    "g"
                    "H"
                  ];
                  desc = "Go to the internal HDD";
                }
                {
                  run = "arrow 5";
                  on = [ "<C-u" ];
                  desc = "Move cursor down by 5 spots";
                }
                {
                  run = "arrow -5";
                  on = [ "<C-u" ];
                  desc = "Move cursor up by 5 spots";
                }
              ];
            };
          };

          settings = {
            headsup.disable_run_warn = true;
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
            };

            opener = {
              edit = [
                {
                  run = ''$EDITOR "$@"'';
                  desc = "Text edit";
                  block = true;
                  for = "unix";
                }
              ];
              open = [
                {
                  run = ''xdg-open "$@"'';
                  desc = "Open";
                  for = "linux";
                }
              ];
              reveal = [
                {
                  run = ''${pkgs.exiftool}/bin/exiftool "$1"; echo "Press enter to exit"; read _'';
                  block = true;
                  desc = "Show EXIF";
                  for = "unix";
                }
              ];
              extract = [
                {
                  run = ''${pkgs.unar}/bin/unar "$1"'';
                  desc = "Extract here";
                  for = "unix";
                }
              ];
              play = [
                {
                  run = ''$MUSIC "$@"'';
                  orphan = true;
                  desc = "Open in music app";
                  for = "unix";
                }
                {
                  run = ''${pkgs.mediainfo}/bin/mediainfo "$1"; echo "Press enter to exit"; read _'';
                  block = true;
                  desc = "Show media info";
                  for = "unix";
                }
              ];
              viewPdf = [
                {
                  run = ''${pkgs.zathura}/bin/zathura "$@"'';
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
      };
}
