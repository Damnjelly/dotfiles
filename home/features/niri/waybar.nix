{ config, ... }: {
  programs.waybar = {
    enable = true;
    settings = [
    {
      layer = "top";
      position = "top";
      output = [ "HDMI-A-1" ];

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
      modules-center = [
      ]; 
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
          default = ["" ""];
        };
        scroll-step = 5;
        on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
      };
      "disk" = {
        format = "{percentage_used}%";
      };
      "memory" = {
        interval = 5;
        format = "Mem {}%";
      };
      "custom/bluetooth" = {
        format = "";
        tooltip-format = "Bluetooth";
        on-click = "blueman-manager";
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
        format-icons = [
          ""
          ""
          ""
          ""
          ""
        ];
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
        on-click = "kitty --class=launcher --title='Connect to Network' -o tab_bar_style=hidden -e sh -c 'killall nmtui; nmtui'";
        max-length = 50;
      };
      "idle_inhibitor" = {
        format = "{icon}";
        format-icons = {
          activated = "";
          deactivated = "";
        };
      };
      "sway/language" = {
        format = "{short} {variant}";
      };
      "tray" = {
        "icon-size" = 18;
      };
      "temperature" = {
        critical-threshold = 80;
        format-critical = "{temperatureC}°C ";
        format = "{temperatureC}°C ";
      };
      "sway/mode" = {
        format = "<span style=\"italic\">{}</span>";
        max-length = 50;
      };
    }
  ];
    style = with config.lib.stylix.colors; ''
   * {
        /* `otf-font-awesome` is required to be installed for icons */
        font-family: "Kirsch2x";
        font-size: 26px;
    }

    window#waybar {
        background-color: #${base01};
        color: #${base0D};
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

    #mode {
        background-color: #${base04};
        border-bottom: 3px solid #${base0D};
    }

    #clock,
    #battery,
    #cpu,
    #memory,
    #disk,
    #temperature,
    #backlight,
    #network,
    #pulseaudio,
    #custom-media,
    #tray,
    #mode,
    #idle_inhibitor,
    #mpd {
        padding: 0 9px;
        color: #${base0D};
    }

    #clock {
        background-color: #${base04};
    }

    #battery {
        background-color: #${base0D};
        color: #${base01};
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
        color: #${base01};
    }

    #memory {
        background-color: #${base0F};
    }

    #disk {
        background-color: #${base07};
    }

    #backlight {
        background-color: #${base05};
    }

    #network {
        background-color: #${base07};
    }

    #network.disconnected {
        background-color: #${base08};
    }

    #pulseaudio {
        background-color: #${base0A};
        color: #${base01};
    }

    #pulseaudio.muted {
        background-color: #${base05};
        color: #${base0A};
    }

    #custom-media {
        background-color: #${base0B};
        color: #${base0A};
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
        background-color: #${base07};
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

    #mpd {
        background-color: #${base0B};
        color: #${base0A};
    }

    #mpd.disconnected {
        background-color: #${base08};
    }

    #mpd.stopped {
        background-color: #${base05};
    }

    #mpd.paused {
        background-color: #${base0C};
    }

    #language {
        color: #${base0C};
        padding: 0 5px;
        min-width: 16px;
    }

    #keyboard-state {
        background: #${base06};
        color: #${base01};
        padding: 0 0px;
        margin: 0 5px;
        min-width: 16px;
    }

    #keyboard-state > label {
        padding: 0 5px;
    }

    #keyboard-state > label.locked {
        background: rgba(0, 0, 0, 0.2);
    }

    window#waybar {
      background: #${base01};
      color: #${base0E};
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

    #workspaces,
    #clock.1,
    #clock.2,
    #clock.3,
    #pulseaudio,
    #custom-bluetooth,
    #memory,
    #cpu,
    #battery,
    #network,
    #disk,
    #language,
    #idle_inhibitor,
    #idle_inhibitor.activated,
    #network.disabled,
    #network.disconnected,
    #temperature,
    #temperature.critical,
    #pulseaudio.muted,
    #tray {
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

    #pulseaudio {
      color: #${base05};
    }
    #memory {
      color: #${base0C};
    }
    #cpu {
      color: #${base07};
    }

    #custom-bluetooth enabled {
      color: #${base0B};
    }

    #battery {
      color: #${base0B};
    }
    #disk {
      color: #${base0A};
    }

    #network.disconnected {
      color: #${base08};
    }
    #network.disabled {
            color: #${base08};
    }

    #idle_inhibitor.activated {
            color: #${base0D};
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

    #pulseaudio.muted {
        color: #${base08};
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
