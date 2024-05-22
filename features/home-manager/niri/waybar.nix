{ config, pkgs, ... }:
let dunst = pkgs.writeShellScriptBin "dunst" "${builtins.readFile ./dunst.sh}";
in {
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
      modules-center =
        [ "custom/dunst-arrow-left" "custom/dunst" "custom/dunst-arrow-right" ];
      modules-right = [
        "custom/disk-arrow-left"
        "disk"
        "custom/disk-arrow-right"
        "custom/memory-arrow-left"
        "memory"
        "custom/memory-arrow-right"
        "custom/cpu-arrow-left"
        "cpu"
        "custom/cpu-arrow-right"
        "custom/bluetooth-arrow-left"
        "custom/bluetooth"
        "custom/bluetooth-arrow-right"
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
      "custom/clock-arrow-left" = {
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
      "custom/pulseaudio-arrow-left" = {
        format = "";
        tooltip = false;
      };
      "custom/pulseaudio-arrow-right" = {
        format = "";
        tooltip = false;
      };

      "custom/dunst" = {
        exec = "${dunst}/bin/dunst.sh";
        on-click = "dunstctl set-paused toggle";
        restart-interval = 1;
      };
      "custom/dunst-arrow-left" = {
        format = "";
        tooltip = false;
      };
      "custom/dunst-arrow-right" = {
        format = "";
        tooltip = false;
      };

      "disk" = { format = " {percentage_used}%"; };
      "custom/disk-arrow-left" = {
        format = "";
        tooltip = false;
      };
      "custom/disk-arrow-right" = {
        format = "";
        tooltip = false;
      };

      "memory" = {
        interval = 5;
        format = "Mem {}%";
      };
      "custom/memory-arrow-left" = {
        format = "";
        tooltip = false;
      };
      "custom/memory-arrow-right" = {
        format = "";
        tooltip = false;
      };

      "custom/bluetooth" = {
        format = "";
        tooltip-format = "Bluetooth";
        on-click = "${pkgs.blueman}/bin/blueman";
      };
      "custom/bluetooth-arrow-left" = {
        format = "";
        tooltip = false;
      };
      "custom/bluetooth-arrow-right" = {
        format = "";
        tooltip = false;
      };

      "cpu" = {
        interval = 5;
        format = "CPU {usage:2}%";
      };
      "custom/cpu-arrow-left" = {
        format = "";
        tooltip = false;
      };
      "custom/cpu-arrow-right" = {
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
      "custom/battery-arrow-left" = {
        format = "";
        tooltip = false;
      };
      "custom/battery-arrow-right" = {
        format = "";
        tooltip = false;
      };

      "network" = {
        format = "{ifname} ";
        format-wifi = "{essid} ({signalStrength}%)  ";
        format-ethernet = "{ifname}  ";
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
      "custom/network-arrow-right" = {
        format = "";
        tooltip = false;
      };

      "tray" = { "icon-size" = 20; };
      "custom/tray-arrow-left" = {
        format = "";
        tooltip = false;
      };
      "custom/tray-arrow-right" = {
        format = "";
        tooltip = false;
      };

      "temperature" = {
        critical-threshold = 80;
        format-critical = "{temperatureC}°C ";
        format = "{temperatureC}°C ";
      };
      "custom/temperature-arrow-left" = {
        format = "";
        tooltip = false;
      };
      "custom/temperature-arrow-right" = {
        format = "";
        tooltip = false;
      };
    }];
    style = with config.lib.stylix.colors; ''
      * {
           font-family: "Kirsch2x, sans-serif";
           font-size: 30px;
       }

       window#waybar {
           background-color: transparent;
           color: transparent;
       }
       
       #workspaces button.focused {
           background-color: rgba(100, 100, 100, 0.07);
           box-shadow: inset 0 -3px #${base0D};
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
       #tray,
       #custom-dunst,
       #mpd {
           padding: 0 9px;
           color: #${base03};
       }



       #custom-clock-arrow-right {
         padding: 0 2px 0 0;
         color: #${base0C};
         background: #${base0A};
       }
       #custom-clock-arrow-left {
         padding: 0 2px 0 0;
         color: #${base03};
         background: #${base0C};
       }
       #clock {
           background-color: #${base0C};
       }



       #custom-dunst-arrow-right {
         padding: 0 2px 0 0;
         color: #${base02};
         background: #${base03};
       }
       #custom-dunst-arrow-left {
         padding: 0 0 0 2px;
         color: #${base02};
         background: #${base03};
       }
       #custom-dunst {
           background-color: #${base0C};
       }



       #battery {
           background-color: #${base0D};
       }
       #custom-battery-arrow-right {
         padding: 0 0 0 2px;
         color: #${base03};
         background: #${base0E};
       }
       #custom-battery-arrow-left {
         padding: 0 0 0 2px;
         color: #${base0E};
         background: #${base03};
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




       #cpu {
           background-color: #${base0E};
       }
       #custom-cpu-arrow-right {
         padding: 0 0 0 2px;
         color: #${base03};
         background: #${base0E};
       }
       #custom-cpu-arrow-left {
         padding: 0 0 0 2px;
         color: #${base0E};
         background: #${base03};
       }



       #memory {
           background-color: #${base0F};
       }
       #custom-memory-arrow-right {
         padding: 0 0 0 2px;
         color: #${base03};
         background: #${base0F};
       }
       #custom-memory-arrow-left {
         padding: 0 0 0 2px;
         color: #${base0F};
         background: #${base03};
       }



       #custom-disk-arrow-right {
         padding: 0 0 0 2px;
         color: #${base03};
         background: #${base07};
       }
       #custom-disk-arrow-left {
         padding: 0 0 0 2px;
         color: #${base07};
         background: #${base03};
       }
       #disk {
           background-color: #${base07};
       }



       #network {
           background-color: #${base07};
       }
       #custom-network-arrow-right {
         padding: 0 0 0 2px;
         color: #${base03};
         background: #${base07};
       }
       #custom-network-arrow-left {
         padding: 0 0 0 2px;
         color: #${base07};
         background: #${base03};
       }

       #network.disconnected {
           background-color: #${base08};
       }



       #pulseaudio {
         background-color: #${base0A};
       }
       #custom-pulseaudio-arrow-right {
         padding: 0 2px 0 0;
         color: #${base0A};
         background: #${base07};
       }
       #custom-pulseaudio-arrow-left {
         padding: 0 2px 0 0;
         color: #${base0A};
         background: #${base03};
       }
       #pulseaudio.muted {
           color: #${base08};
       }



       #temperature {
           background-color: #${base09};
       }
       #custom-temperature-arrow-right {
         padding: 0 0 0 2px;
         color: #${base07};
         background: transparent;
       }
       #custom-temperature-arrow-left {
         padding: 0 0 0 2px;
         color: #${base0E};
         background: #${base03};
       }
       #temperature.critical {
           color: #${base09};
           animation-name: blink;
           animation-duration: 2s;
           animation-timing-function: linear;
           animation-iteration-count: infinite;
           animation-direction: alternate;
       }



       #tray {
           background-color: #${base07};
       }
       #custom-tray-arrow-right {
         padding: 0 2px 0 0;
         color: #${base07};
         background: transparent;
       }
       #custom-tray-arrow-left {
         padding: 0 2px 0 0;
         color: #${base07};
         background: #${base03};
       }
       #tray > .passive {
           -gtk-icon-effect: dim;
       }
       #tray > .needs-attention {
           -gtk-icon-effect: highlight;
           color: #${base08};
       }    '';
  };
}
