{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}:
{
  options.features.music.enable = lib.mkEnableOption "music";

  config = {
    home = lib.mkIf config.features.music.enable {
      packages = with pkgs; [
        amberol
        tagger
        adwaita-icon-theme
        rmpc
      ];
      persistence = lib.mkIf osConfig.optinpermanence.enable {
        "/persist/home/${config.home.username}/music" = {
          directories = [ ".cache/amberol" ];
          allowOther = true;
        };
      };
      sessionVariables = {
        MUSIC = "amberol";
      };
    };
    services.mpd = {
      enable = true;
      network.listenAddress = "any";
      musicDirectory = "${config.home.homeDirectory}/Music";
      extraConfig = ''
        audio_output {
          type "pipewire"
          name "Starship/Matisse HD Audio Controller Analog Stereo"
        }
      '';
    };
    xdg = {
      desktopEntries.rmpc = {
        name = "rmpc";
        genericName = "MPD Client";
        exec = "rmpc";
        terminal = true;
      };
      configFile."rmpc/config.ron".text = # ron
        ''
          #![enable(implicit_some)]
          #![enable(unwrap_newtypes)]
          #![enable(unwrap_variant_newtypes)]
          (
              address: "127.0.0.1:6600",
              password: None,
              theme: None,
              cache_dir: None,
              lyrics_dir: "${config.home.homeDirectory}/Music", 
              on_song_change: None,
              volume_step: 5,
              scrolloff: 0,
              wrap_navigation: false,
              enable_mouse: true,
              status_update_interval_ms: 1000,
              select_current_song_on_change: false,
              album_art: (
                  method: Auto,
                  max_size_px: (width: 600, height: 600),
              ),
              keybinds: (
                  global: {
                      ":":       CommandMode,
                      ",":       VolumeDown,
                      "s":       Stop,
                      ".":       VolumeUp,
                      "c":       ToggleSingle,
                      "<Tab>":   NextTab,
                      "<S-Tab>": PreviousTab,
                      "1":       SwitchToTab("Queue"),
                      "2":       SwitchToTab("Directories"),
                      "3":       SwitchToTab("Artists"),
                      "4":       SwitchToTab("Albums"),
                      "5":       SwitchToTab("Playlists"),
                      "6":       SwitchToTab("Search"),
                      "q":       Quit,
                      "x":       ToggleRandom,
                      ">":       NextTrack,
                      "<":       PreviousTrack,
                      "f":       SeekForward,
                      "v":       ToggleConsume,
                      "p":       TogglePause,
                      "z":       ToggleRepeat,
                      "b":       SeekBack,
                      "?":       ShowHelp,
                      "I":       ShowCurrentSongInfo,
                      "O":       ShowOutputs,
                  },
                  navigation: {
                      "k":       Up,
                      "j":       Down,
                      "h":       Left,
                      "l":       Right,
                      "<Up>":    Up,
                      "<Down>":  Down,
                      "<Left>":  Left,
                      "<Right>": Right,
                      "<C-k>":   PaneUp,
                      "<C-j>":   PaneDown,
                      "<C-h>":   PaneLeft,
                      "<C-l>":   PaneRight,
                      "<C-u>":   UpHalf,
                      "N":       PreviousResult,
                      "a":       Add,
                      "A":       AddAll,
                      "r":       Rename,
                      "n":       NextResult,
                      "g":       Top,
                      "<Space>": Select,
                      "G":       Bottom,
                      "<CR>":    Confirm,
                      "i":       FocusInput,
                      "J":       MoveDown,
                      "<C-d>":   DownHalf,
                      "/":       EnterSearch,
                      "<C-c>":   Close,
                      "<Esc>":   Close,
                      "K":       MoveUp,
                      "D":       Delete,
                  },
                  queue: {
                      "D":       DeleteAll,
                      "<CR>":    Play,
                      "<C-s>":   Save,
                      "a":       AddToPlaylist,
                      "d":       Delete,
                      "i":       ShowInfo,
                  },
              ),
              search: (
                  case_sensitive: false,
                  mode: Contains,
                  tags: [
                      (value: "any",         label: "Any Tag"),
                      (value: "artist",      label: "Artist"),
                      (value: "album",       label: "Album"),
                      (value: "albumartist", label: "Album Artist"),
                      (value: "title",       label: "Title"),
                      (value: "filename",    label: "Filename"),
                      (value: "genre",       label: "Genre"),
                  ],
              ),
              tabs: [
                  (
                      name: "Queue",
                      border_type: None,
                      pane: Split(
                          direction: Horizontal,
                          panes: [(size: "40%", pane: Pane(AlbumArt)), (size: "60%", pane: Pane(Queue))],
                      ),
                  ),
                  (
                      name: "Directories",
                      border_type: None,
                      pane: Pane(Directories),
                  ),
                  (
                      name: "Artists",
                      border_type: None,
                      pane: Pane(Artists),
                  ),
                  (
                      name: "Album Artists",
                      border_type: None,
                      pane: Pane(AlbumArtists),
                  ),
                  (
                      name: "Albums",
                      border_type: None,
                      pane: Pane(Albums),
                  ),
                  (
                      name: "Playlists",
                      border_type: None,
                      pane: Pane(Playlists),
                  ),
                  (
                      name: "Search",
                      border_type: None,
                      pane: Pane(Search),
                  ),
              ],
          )        
        '';
      configFile."rmpc/theme.ron".text = # ron
        ''
          #![enable(implicit_some)]
          #![enable(unwrap_newtypes)]
          #![enable(unwrap_variant_newtypes)]
          (
              album_art_position: Left,
              album_art_width_percent: 40,
              default_album_art_path: None,
              show_song_table_header: true,
              draw_borders: true,
              browser_column_widths: [20, 38, 42],
              background_color: None,
              text_color: None,
              header_background_color: None,
              modal_background_color: None,
              tab_bar: (
                  enabled: true,
                  active_style: (fg: "black", bg: "blue", modifiers: "Bold"),
                  inactive_style: (),
              ),
              highlighted_item_style: (fg: "blue", modifiers: "Bold"),
              current_item_style: (fg: "black", bg: "blue", modifiers: "Bold"),
              borders_style: (fg: "blue"),
              highlight_border_style: (fg: "blue"),
              symbols: (song: "S", dir: "D", marker: "M"),
              progress_bar: (
                  symbols: ["-", ">", " "],
                  track_style: (fg: "#1e2030"),
                  elapsed_style: (fg: "blue"),
                  thumb_style: (fg: "blue", bg: "#1e2030"),
              ),
              scrollbar: (
                  symbols: ["│", "█", "▲", "▼"],
                  track_style: (),
                  ends_style: (),
                  thumb_style: (fg: "blue"),
              ),
              song_table_format: [
                  (
                      prop: (kind: Property(Artist),
                          default: (kind: Text("Unknown"))
                      ),
                      width_percent: 20,
                  ),
                  (
                      prop: (kind: Property(Title),
                          default: (kind: Text("Unknown"))
                      ),
                      width_percent: 35,
                  ),
                  (
                      prop: (kind: Property(Album), style: (fg: "white"),
                          default: (kind: Text("Unknown Album"), style: (fg: "white"))
                      ),
                      width_percent: 30,
                  ),
                  (
                      prop: (kind: Property(Duration),
                          default: (kind: Text("-"))
                      ),
                      width_percent: 15,
                      alignment: Right,
                  ),
              ],
              header: (
                  rows: [
                      (
                          left: [
                              (kind: Text("["), style: (fg: "yellow", modifiers: "Bold")),
                              (kind: Property(Status(State)), style: (fg: "yellow", modifiers: "Bold")),
                              (kind: Text("]"), style: (fg: "yellow", modifiers: "Bold"))
                          ],
                          center: [
                              (kind: Property(Song(Title)), style: (modifiers: "Bold"),
                                  default: (kind: Text("No Song"), style: (modifiers: "Bold"))
                              )
                          ],
                          right: [
                              (kind: Property(Widget(Volume)), style: (fg: "blue"))
                          ]
                      ),
                      (
                          left: [
                              (kind: Property(Status(Elapsed))),
                              (kind: Text(" / ")),
                              (kind: Property(Status(Duration))),
                              (kind: Text(" (")),
                              (kind: Property(Status(Bitrate))),
                              (kind: Text(" kbps)"))
                          ],
                          center: [
                              (kind: Property(Song(Artist)), style: (fg: "yellow", modifiers: "Bold"),
                                  default: (kind: Text("Unknown"), style: (fg: "yellow", modifiers: "Bold"))
                              ),
                              (kind: Text(" - ")),
                              (kind: Property(Song(Album)),
                                  default: (kind: Text("Unknown Album"))
                              )
                          ],
                          right: [
                              (
                                  kind: Property(Widget(States(
                                      active_style: (fg: "white", modifiers: "Bold"),
                                      separator_style: (fg: "white")))
                                  ),
                                  style: (fg: "dark_gray")
                              ),
                          ]
                      ),
                  ],
              ),
              browser_song_format: [
                  (
                      kind: Group([
                          (kind: Property(Track)),
                          (kind: Text(" ")),
                      ])
                  ),
                  (
                      kind: Group([
                          (kind: Property(Artist)),
                          (kind: Text(" - ")),
                          (kind: Property(Title)),
                      ]),
                      default: (kind: Property(Filename))
                  ),
              ],
          )
        '';
    };
  };
}
