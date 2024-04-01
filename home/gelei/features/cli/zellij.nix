{
  pkgs,
  inputs,
  config,
  ...
}: {
  xdg.configFile."zellij/quickstart.kdl".text = with config.lib.stylix.colors; ''
    layout {
    		default_tab_template {
            pane size=2 borderless=true {
                plugin location="file:${inputs.zjstatus.packages.${pkgs.system}.default}/bin/zjstatus.wasm" {
                    format_left 	"#[bg=#${base01}] {tabs}"
                    format_right  "#[bg=#${base01}] {datetime}"
                    format_space  "#[bg=#${base01}] "

                    mode_normal  "#[bg=#${base0F}]"

    								tab_normal "#[bg=#${base02},fg=#${base01}] #[bg=#${base02},fg=#${base01},bold]{name} {sync_indicator}{fullscreen_indicator}{floating_indicator} #[bg=#${base01},fg=#${base02}] "
                		tab_active "#[bg=#${base0F},fg=#${base01}] #[bg=#${base0F},fg=#${base01},bold]{name} {sync_indicator}{fullscreen_indicator}{floating_indicator} #[bg=#${base01},fg=#${base0F}] "

    								tab_sync_indicator       " "
                		tab_fullscreen_indicator "□ "
                		tab_floating_indicator   "󰉈 "

    								datetime     "#[fg=#${base05},bg=#${base01},bold] {format} "
                    datetime_format "%A | %d %b | %H:%M"
                    datetime_timezone "Europe/Berlin"
                }
            }
    				children
    				pane size=2 borderless=true {
    						plugin location="zellij:status-bar"
    				}
        }
    		tab name="Files"{
    				pane command="yazi" borderless=true
    		}
    		tab name="Code"{
    				pane command="nvim" borderless=true
    				pane name="terminal" size="20%" borderless=true
    		}
    }
  '';
  programs.zellij = {
    enable = true;
    package = pkgs.zellij;
    enableBashIntegration = true;
    settings = {
      setup = "--layout ~/.config/zellij/quickstart.kdl";
    };
  };
}
