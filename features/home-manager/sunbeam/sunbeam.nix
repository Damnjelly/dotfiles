{ config, ... }: {
  xdg.configFile = {
    "sunbeam/extensions/volumemixer.sh" = {
      text = "${builtins.readFile ./volumemixer.sh}";
      executable = true;
      onChange = "chmod +w ~/.config/sunbeam/extensions/volumemixer.sh";
    };
    "sunbeam/extensions/applauncher.sh" = {
      text = "${builtins.readFile ./applauncher.sh}";
      executable = true;
      onChange = "chmod +w ~/.config/sunbeam/extensions/applauncher.sh";
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
        #TODO: Figurue out how this outofstoresymlink shit works
        volumemixer = {
          origin =
            "~/Documents/nix-config/home-manager/features/sunbeam/volumemixer.sh";
        };
        applauncher = {
          origin =
            "~/Documents/nix-config/home-manager/features/sunbeam/applauncher.sh";
        };
      };
    };
  };
}
