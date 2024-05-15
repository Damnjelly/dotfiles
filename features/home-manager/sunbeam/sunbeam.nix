{ config, ... }: {
  xdg = {
    configFile."sunbeam/HMInit/volumemixer" = {
      text = "${builtins.readFile ./volumemixer.sh}";
      executable = true;
      onChange = ''
        cp ${config.xdg.configHome}/sunbeam/HMInit/volumemixer ${config.xdg.configHome}/sunbeam/volumemixer 
        chmod u+w ${config.xdg.configHome}/sunbeam/volumemixer
      '';
    };
    configFile."sunbeam/HMInit/applauncher" = {
      text = "${builtins.readFile ./applauncher.sh}";
      executable = true;
      onChange = ''
        cp ${config.xdg.configHome}/sunbeam/HMInit/applauncher ${config.xdg.configHome}/sunbeam/applauncher 
        chmod u+w ${config.xdg.configHome}/sunbeam/applauncher
      '';
    };
  };
  programs.sunbeam = {
    enable = true;
    settings = {
      oneliners = [
        {
          title = "Open Sunbeam Docs";
          command = "Sunbeam open https://pomdtr.github.io/sunbeam";
          exit = true;
        }
        {
          title = "Power off Computer";
          command = "poweroff";
          exit = true;
        }
        {
          title = "Reboot Computer";
          command = "reboot";
          exit = true;
        }
      ];
      extensions = {
        nixpkgs = {
          origin =
            "https://raw.githubusercontent.com/pomdtr/sunbeam/main/extensions/nixpkgs.ts";
        };
        volumemixer = {
          origin = "${config.xdg.configHome}/sunbeam/volumemixer";
        };
        applauncher = {
          origin = "${config.xdg.configHome}/sunbeam/applauncher";
        };
      };
    };
  };
}
