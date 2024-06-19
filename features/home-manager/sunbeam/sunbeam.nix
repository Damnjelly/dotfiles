{ config, pkgs, ... }:
{
  xdg = with config.lib.stylix.colors; {
    configFile."sunbeam/HMInit/volumemixer.sh" = {
      text = "${builtins.readFile ./volumemixer.sh}";
      executable = true;
      onChange = ''
        cp ${config.xdg.configHome}/sunbeam/HMInit/volumemixer.sh ${config.xdg.configHome}/sunbeam/volumemixer.sh 
        chmod u+w ${config.xdg.configHome}/sunbeam/volumemixer.sh
      '';
    };

    configFile."sunbeam/HMInit/applauncher.sh" = {
      text = "${builtins.readFile ./applauncher.sh}";
      executable = true;
      onChange = ''
        cp ${config.xdg.configHome}/sunbeam/HMInit/applauncher.sh ${config.xdg.configHome}/sunbeam/applauncher.sh 
        chmod u+w ${config.xdg.configHome}/sunbeam/applauncher.sh
      '';
    };

    configFile."sunbeam/HMInit/nixos-search.sh" = {
      text = "${builtins.readFile ./nixos-search.sh}";
      executable = true;
      onChange = ''
        cp ${config.xdg.configHome}/sunbeam/HMInit/nixos-search.sh ${config.xdg.configHome}/sunbeam/nixos-search.sh 
        chmod u+w ${config.xdg.configHome}/sunbeam/nixos-search.sh
      '';
    };

    configFile."sunbeam/HMInit/bluetooth.sh" = {
      text = "${builtins.readFile ./bluetooth.sh}";
      executable = true;
      onChange = ''
        cp ${config.xdg.configHome}/sunbeam/HMInit/bluetooth.sh ${config.xdg.configHome}/sunbeam/bluetooth.sh 
        chmod u+w ${config.xdg.configHome}/sunbeam/bluetooth.sh
      '';
    };

    configFile."sunbeam/HMInit/calculator.sh" = {
      text = "${builtins.readFile ./calculator.sh}";
      executable = true;
      onChange = ''
        cp ${config.xdg.configHome}/sunbeam/HMInit/calculator.sh ${config.xdg.configHome}/sunbeam/calculator.sh 
        chmod u+w ${config.xdg.configHome}/sunbeam/calculator.sh
      '';
    };

    configFile."sunbeam/HMInit/poweroff.sh" = {
      text = ''
        #!/bin/sh

        # check if jq is installed
        if ! [ -x "$(command -v jq)" ]; then
          echo "jq is not installed. Please install it." >&2
          exit 1
        fi

        if [ $# -eq 0 ]; then
          jq -n '
        {
          title: "Poweroff",
          description: "Manage bluetooth devices",
          commands: 
          [
            { 
              name: "poweroff", 
              title: "📀 Power off Computer", 
              mode: "tty"
            }
          ]
        }'
          exit 0
        fi

        # check if gum is installed
        if ! [ -x "$(command -v gum)" ]; then
          echo "gum is not installed. Please install it." >&2
          exit 1
        fi 

        COMMAND=$(echo "$1" | jq -r '.command')
        if [ "$COMMAND" = "poweroff" ]; then
                  gum confirm 'Power off the system?' --prompt.foreground='#${base0B}' --selected.background='#${base0A}' --unselected.background='#${base03}' && poweroff || exit 0;
        fi
      '';
      executable = true;
      onChange = ''
        cp ${config.xdg.configHome}/sunbeam/HMInit/poweroff.sh ${config.xdg.configHome}/sunbeam/poweroff.sh 
        chmod u+w ${config.xdg.configHome}/sunbeam/poweroff.sh
      '';
    };

    configFile."sunbeam/HMInit/reboot.sh" = {
      text = ''
        #!/bin/sh

        # check if jq is installed
        if ! [ -x "$(command -v jq)" ]; then
          echo "jq is not installed. Please install it." >&2
          exit 1
        fi

        if [ $# -eq 0 ]; then
          jq -n '
        {
          title: "Reboot",
          description: "Manage bluetooth devices",
          commands: 
          [
            { 
              name: "reboot", 
              title: "📀 Reboot Computer", 
              mode: "tty"
            }
          ]
        }'
          exit 0
        fi

        # check if gum is installed
        if ! [ -x "$(command -v gum)" ]; then
          echo "gum is not installed. Please install it." >&2
          exit 1
        fi 

        COMMAND=$(echo "$1" | jq -r '.command')
        if [ "$COMMAND" = "reboot" ]; then
                  gum confirm 'Reboot the system?' --prompt.foreground='#${base0B}' --selected.background='#${base0A}' --unselected.background='#${base03}' && reboot || exit 0;
        fi
      '';
      executable = true;
      onChange = ''
        cp ${config.xdg.configHome}/sunbeam/HMInit/reboot.sh ${config.xdg.configHome}/sunbeam/reboot.sh 
        chmod u+w ${config.xdg.configHome}/sunbeam/reboot.sh
      '';
    };
  };
  programs.sunbeam = {
    enable = true;
    settings = {
      extensions = {
        volumemixer = {
          origin = "${config.xdg.configHome}/sunbeam/volumemixer.sh";
        };
        bitwarden = {
          origin = "https://raw.githubusercontent.com/Damnjelly/sunbeam/main/extensions/bitwarden.sh";
          preferences.sessionPath = "${config.sops.secrets."nightglider/gelei/bitwardensession".path}";
        };
        nixos-search = {
          origin = "${config.xdg.configHome}/sunbeam/nixos-search.sh";
          preferences.nixchannel = "unstable";
        };
        applauncher = {
          origin = "${config.xdg.configHome}/sunbeam/applauncher.sh";
        };
        bluetooth = {
          origin = "${config.xdg.configHome}/sunbeam/bluetooth.sh";
        };
        calculator = {
          origin = "${config.xdg.configHome}/sunbeam/calculator.sh";
        };
        poweroff = {
          origin = "${config.xdg.configHome}/sunbeam/poweroff.sh";
        };
        reboot = {
          origin = "${config.xdg.configHome}/sunbeam/reboot.sh";
        };
      };
    };
  };
}
