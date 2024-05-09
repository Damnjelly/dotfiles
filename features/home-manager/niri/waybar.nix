{ config, pkgs, ... }: {
  stylix.targets.waybar.enable = false;
  programs.waybar = {
    enable = true;
    settings = [{
      layer = "top";
      position = "top";
      output = [ "DP-1" ];

      modules-left = [
        "clock#1"
        "custom/right-arrow-dark"
        "custom/right-arrow-light"
        "clock#2"
        "custom/right-arrow-dark"
        "custom/right-arrow-light"
        "clock#3"
        "custom/right-arrow-dark"
      ];
      modules-center = [ ];
      modules-right = [
        "custom/left-arrow-dark"
        "disk"
        "custom/left-arrow-light"
        "custom/left-arrow-dark"
        "pulseaudio"
        "custom/left-arrow-light"
        "custom/left-arrow-dark"
        "tray"
      ];

      "custom/left-arrow-dark" = {
        format = "";
        tooltip = false;
      };
      "custom/left-arrow-light" = {
        format = "";
        tooltip = false;
      };
      "custom/right-arrow-dark" = {
        format = "";
        tooltip = false;
      };
      "custom/right-arrow-light" = {
        format = "";
        tooltip = false;
      };

      "clock#1" = {
        format = " {:%a} ";
        tooltip = false;
      };
      "clock#2" = {
        format = " {:%H:%M} ";
        tooltip = false;
      };
      "clock#3" = {
        format = " {:%d-%m} ";
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

      "disk" = { format = " {percentage_used}%"; };

      "memory" = {
        interval = 5;
        format = "Mem {}%";
      };

      "custom/bluetooth" = {
        format = "";
        tooltip-format = "Bluetooth";
        on-click = "${pkgs.blueman}/bin/blueman";
      };

      "cpu" = {
        interval = 5;
        format = "CPU {usage:2}%";
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

      "network" = {
        format = "{ifname}";
        format-wifi = "{essid} ({signalStrength}%) ";
        format-ethernet = "{ifname} ";
        format-disabled = "";
        format-disconnected = "  ";
        tooltip-format = "{ifname}";
        tooltip-format-wifi = "{essid} {signalStrength}%  ";
        tooltip-format-ethernet = "{ifname}  ";
        tooltip-format-disconnected = "Disconnected";
        on-click =
          "kitty --class=launcher --title='Connect to Network' -o tab_bar_style=hidden -e sh -c 'killall nmtui; nmtui'";
        max-length = 50;
      };

      "tray" = { "icon-size" = 20; };

      "temperature" = {
        critical-threshold = 80;
        format-critical = "{temperatureC}°C ";
        format = "{temperatureC}°C ";
      };
    }];
    style = with config.lib.stylix.colors; ''
      * {
           font-family: "Kirsch2x, sans-serif";
           font-size: 32px;
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

       #clock,
       #battery,
       #cpu,
       #memory,
       #disk,
       #temperature,
       #network,
       #pulseaudio,
       #custom-media,
       #tray,
       #idle_inhibitor,
       #mpd {
           padding: 0 9px;
           color: #${base02};
       }

       #clock {
           background-color: #${base0C};
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

       @keyframes blink {
           to {
               color: #${base0D};
           }
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

       #memory {
           background-color: #${base0F};
       }

       #disk {
           background-color: #${base07};
       }

       #network {
           background-color: #${base07};
       }

       #network.disconnected {
           background-color: #${base08};
       }

       #pulseaudio {
           background-color: #${base0A};
       }

       #pulseaudio.muted {
           background-color: #${base08};
       }

       #custom-media {
           background-color: #${base0B};
           min-width: 100px;
       }

       #custom-media.custom-spotify {
           background-color: #${base0B};
       }

       #custom-media.custom-vlc {
           background-color: #${base09};
       }

       #temperature {
           background-color: #${base09};
       }

       #temperature.critical {
           background-color: #${base08};
       }

       #tray {
           background-color: #${base0C};
       }

       #tray > .passive {
           -gtk-icon-effect: dim;
       }

       #tray > .needs-attention {
           -gtk-icon-effect: highlight;
           background-color: #${base08};
       }

       #idle_inhibitor {
           background-color: #${base04};
       }

       #idle_inhibitor.activated {
           background-color: #${base06};
           color: #${base04};
       }

       #custom-right-arrow-dark,
       #custom-left-arrow-dark,
       #custom-right-arrow-light,
       #custom-left-arrow-light {
         padding: 0px 0px 0px 0px;
         margin: 0px 0px 0px 0px;
         margin-top: 0px;
         margin-bottom: 0px;
       }


       #custom-right-arrow-dark,
       #custom-left-arrow-dark {
         color: #${base02};
       }
       #custom-right-arrow-light,
       #custom-left-arrow-light {
         color: #${base01};
         background: #${base02};
       }

       #workspaces button {
         padding: 0 2px;
         color: #${base0E};
       }
       #workspaces button.focused {
         color: #${base05};
       }
       #workspaces button:hover {
         box-shadow: inherit;
         text-shadow: inherit;
       }
       #workspaces button:hover {
         background: #${base02};
         border: #${base02};
         padding: 0 3px;
       }

       #idle_inhibitor.deactivated {
               color: rgb(180, 180, 180);
       }

       #temperature.critical {
           color: #${base08};
           animation-name: blink;
           animation-duration: 2s;
           animation-timing-function: linear;
           animation-iteration-count: infinite;
           animation-direction: alternate;
       }

       #clock,
       #custom-bluetooth,
       #network,
       #pulseaudio,
       #memory,
       #cpu,
       #battery,
       #disk {
         padding: 0 10px;
       }    '';
  };
}
