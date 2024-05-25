{ config, ... }: {
  xdg = {
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
  };
  programs.sunbeam = {
    enable = true;
    settings = {
      oneliners = [
        {
          title = "📀 Power off Computer";
          command = "poweroff";
          exit = true;
        }
        {
          title = "💿 Reboot Computer";
          command = "reboot";
          exit = true;
        }
      ];
      extensions = {
        volumemixer = {
          origin = "${config.xdg.configHome}/sunbeam/volumemixer.sh";
        };
        nixos-search = {
          origin = "${config.xdg.configHome}/sunbeam/nixos-search.sh";
          preferences.nix-channel = "unstable";
        };
        applauncher = {
          origin = "${config.xdg.configHome}/sunbeam/applauncher.sh";
        };
      };
    };
  };
}
