{ pkgs, inputs, config, ... }: {
  stylix.targets.zellij.enable = true;
  xdg.configFile."zellij/quickstart.kdl".text =
                       # format_right  "#[bg=#${base01}] {command_disk}#[bg=#${base01}] {command_volume}#[bg=#${base01}] {datetime}"
    with config.lib.stylix.colors; ''
      layout {
          default_tab_template {
              children
              pane size=1 borderless=true {
                  plugin location="file:${
                    inputs.zjstatus.packages.${pkgs.system}.default
                  }/bin/zjstatus.wasm" {
                      format_left 	"#[bg=#${base01}] {tabs}"
                      format_space  "#[bg=#${base01}] "

                      mode_normal  "#[bg=#${base0F}]"

      								tab_normal "#[bg=#${base02},fg=#${base01}] #[bg=#${base02},fg=#${base01},bold]{name} #[bg=#${base01},fg=#${base02}] "
                      tab_active "#[bg=#${base0F},fg=#${base01}] #[bg=#${base0F},fg=#${base01},bold]{name} #[bg=#${base01},fg=#${base0F}] "

                      command_disk_command "bash -c \"df /dev/nvme0n1p2 --output=pcent | grep '[[:digit:]]'\""
                      command_disk_format "#[bg=#${base01},fg=#${base05}]  {stdout}"
                      command_disk_interval "60"

                      command_volume_command "bash -c \"pactl get-sink-volume @DEFAULT_SINK@ | perl -nle 'print $1 if /([0-9]+%)/'\""
                      command_volume_format "#[bg=#${base01},fg=#${base05}] 󰕾 {stdout}" 

      								datetime     "#[fg=#${base05},bg=#${base01},bold] {format} "
                      datetime_format "%A | %d %b | %H:%M"
                      datetime_timezone "Europe/Berlin"
                  }
              }
          }
      		tab name="Files"{
      				pane command="yazi" borderless=true
      		}
      		tab name="Code"{
      			  pane command="nvim" borderless=true
      			  pane size="20%" borderless=true
          } 
        }'';
  programs.zellij = {
    enable = true;
    package = pkgs.zellij;
    settings = {
      setup = "--layout ~/.config/zellij/quickstart.kdl";
      on_force_close = "quit";
      keybinds = { unbind = "Ctrl q"; };
    };
  };
}
