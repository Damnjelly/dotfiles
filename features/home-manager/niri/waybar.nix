{ config, lib, pkgs, ... }:
let
  polytiramisu = pkgs.writeShellScript "polytiramisu.sh"
    "${builtins.readFile ./waybar-polytiramisu.sh}";
in {
  programs.niri.settings.spawn-at-startup =
    lib.mkIf config.programs.niri.enable [{
      command = [ "${pkgs.waybar}/bin/waybar" ];
    }];
  home.packages = with pkgs; [ tiramisu killall ];
  stylix.targets.waybar.enable = false;
  programs.waybar = {
    enable = true;
    settings = [{
      layer = "top";
      position = "top";
      output = [ "DP-1" ];

      modules-left = [
        "clock#1"
        "custom/clock-arrow-right"
        "pulseaudio"
        "custom/pulseaudio-arrow-right"
        "tray"
        "custom/tray-arrow-right"
      ];
      modules-center = [
        "custom/polytiramisu"
      ];
      modules-right = [
        "custom/disk-arrow-left"
        "disk"
        "custom/memory-arrow-left"
        "memory"
        "custom/cpu-arrow-left"
        "cpu"
        "custom/network-arrow-left"
        "network"
      ];

      "clock#1" = {
        format = " {:%a %H:%M %d-%m} ";
        tooltip = false;
      };
      "custom/clock-arrow-right" = {
        format = "";
        tooltip = false;
      };

      "pulseaudio" = {
        format = "{icon} {volume:2}%";
        format-bluetooth = "{icon} {volume}%";
        format-muted = "MUTE";
        format-icons = {
          headphones = "";
          headset = "";
          hands-free = "";
          phone = "";
          portable = "";
          car = "";
          default = [ "" "" ];
        };
        scroll-step = 5;
        on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
      };
      "custom/pulseaudio-arrow-right" = {
        format = "";
        tooltip = false;
      };

      "disk" = { format = " {percentage_used}%"; };
      "custom/disk-arrow-left" = {
        format = "";
        tooltip = false;
      };

      "battery" = {
        states = {
          good = 95;
          warning = 30;
          critical = 15;
          death = 10;
        };
        bat = "BAT0";
        adapter = "AC0";
        format = "{icon} {capacity}%";
        format-time = "{H} hrs {M} mins";
        format-charging = " {icon} {capacity}%";
        full-at = "99";
        format-icons = [ "" "" "" "" "" ];
      };
      "custom/battery-arrow-right" = {
        format = "";
        tooltip = false;
      };

      "custom/polytiramisu" = {
        format = "{}";
        exec = "${polytiramisu}";
      };

      "memory" = {
        interval = 5;
        format = " {}%";
      };
      "custom/memory-arrow-left" = {
        format = "";
        tooltip = false;
      };

      "cpu" = {
        interval = 5;
        format = "{usage:2}%";
      };
      "custom/cpu-arrow-left" = {
        format = "";
        tooltip = false;
      };

      "network" = {
        format = "";
        format-wifi = "({signalStrength}%)  ";
        format-ethernet = "󰌗 ";
        format-disabled = " ";
        format-disconnected = "  ";
        tooltip-format = "{ifname}";
        tooltip-format-wifi = "{essid} {signalStrength}%  ";
        tooltip-format-ethernet = "{ifname}  ";
        tooltip-format-disconnected = "Disconnected ";
        on-click =
          "foot --title='Connect to Network' sh -c 'killall nmtui; nmtui'";
        max-length = 50;
      };
      "custom/network-arrow-left" = {
        format = "";
        tooltip = false;
      };

      "tray" = { "icon-size" = 20; };
      "custom/tray-arrow-right" = {
        format = "";
        tooltip = false;
      };

      "temperature" = {
        critical-threshold = 80;
        format-critical = "{temperatureC}°C ";
        format = "{temperatureC}°C ";
      };
      "custom/temperature-arrow-right" = {
        format = "";
        tooltip = false;
      };
    }];
    style = with config.lib.stylix.colors;
      with config.stylix; ''
        * {
             font-family: "${config.stylix.fonts.monospace.name}";
             font-size: ${
               builtins.toString (config.stylix.fonts.sizes.terminal + 4)
             }px;
         }

         window#waybar {
           background-color: transparent;
         }

         window#waybar > box {
             background-color: #${base02};
             margin: 0px 0px 20px 0px;
             box-shadow: 0px 10px 6px 6px #${base01}77;
         }
         
         #workspaces button.focused {
             background-color: rgba(100, 100, 100, 0.07);
             border-radius: 0;
         }

         #workspaces button.urgent {
             box-shadow: inset 0 -3px #${base08};
             border-radius: 0;    
         }

         @keyframes blink {
           to {
             color: #${base0D};
           }
         }



         #clock,
         #battery,
         #cpu,
         #memory,
         #disk,
         #temperature,
         #network,
         #pulseaudio,
         #custom-bluetooth,
         #custom-polytiramisu,
         #tray,
         #mpd {
             padding: 0 9px;
             color: #${base03};
         }



         #custom-polytiramisu {
           background-color: #${base08};
           color: #${base06};
         }
         #custom-polytiramisu-arrow-right {
           color: #${base03};
           background: #${base08};
         }
         #custom-polytiramisu-arrow-left {
           color: #${base08};
           background: transparent;
         }


         #clock {
           background-color: #${base0C};
         }
         #custom-clock-arrow-right {
           padding: 0 2px 0 0;
           color: #${base0C};
           background: #${base0A};
         }



         #battery {
             background-color: #${base0D};
         }
         #battery.charging, #battery.plugged {
             color: #${base0C};
         }
         battery.warning {
             color: #${base0A};
         }
         #battery.good:not(.charging) {
             color: #${base0B};
         }
         #battery.critical:not(.charging) {
             color: #${base08};
             animation-name: blink;
             animation-duration: 0.5s;
             animation-timing-function: linear;
             animation-iteration-count: infinite;
             animation-direction: alternate;
         }
         #battery.death:not(.charging) {
             color: #${base08};
             animation-name: blink;
             animation-duration: 0.1s;
             animation-timing-function: linear;
             animation-iteration-count: infinite;
             animation-direction: alternate;
         }
         label:focus {
             background-color: #${base01};
         }
         #custom-battery-arrow-right {
           padding: 0 0 0 2px;
           color: #${base03};
           background: #${base0E};
         }




         #cpu {
             background-color: #${base0E};
         }
         #custom-cpu-arrow-left {
           padding: 0 0 0 2px;
           color: #${base0E};
           background: #${base0F};
         }



         #memory {
             background-color: #${base0F};
         }
         #custom-memory-arrow-left {
           padding: 0 0 0 2px;
           color: #${base0F};
           background: #${base07};
         }



         #disk {
           background-color: #${base07};
         }
         #custom-disk-arrow-left {
           padding: 0 0 0 2px;
           color: #${base07};
           background: transparent;
         }



         #network {
             background-color: #${base07};
         }
         #network.disconnected {
           background-color: #${base08};
         }
         #custom-network-arrow-left {
           padding: 0 0 0 2px;
           color: #${base07};
           background: #${base0E};
         }




         #pulseaudio {
           background-color: #${base0A};
         }
         #pulseaudio.muted {
             color: #${base08};
         }
         #custom-pulseaudio-arrow-right {
           padding: 0 2px 0 0;
           color: #${base0A};
           background: #${base07};
         }



         #temperature {
             background-color: #${base09};
         }
         #temperature.critical {
             color: #${base09};
             animation-name: blink;
             animation-duration: 2s;
             animation-timing-function: linear;
             animation-iteration-count: infinite;
             animation-direction: alternate;
         }
         #custom-temperature-arrow-right {
           padding: 0 0 0 2px;
           color: #${base07};
           background: transparent;
         }



         #tray {
             background-color: #${base07};
         }
         #tray > .passive {
             -gtk-icon-effect: dim;
         }
         #tray > .needs-attention {
             -gtk-icon-effect: highlight;
             color: #${base08};
         }
         #custom-tray-arrow-right {
           padding: 0 2px 0 0;
           color: #${base07};
           background: transparent;
         }    '';
  };
}
