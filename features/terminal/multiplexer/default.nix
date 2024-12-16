{
  config,
  osConfig,
  lib,
  ...
}:
{

  config = lib.mkIf osConfig.features.terminal.enable {
    home.file.".config/zellij/layouts/development.kdl".text =
      "${builtins.readFile ./layouts/development.kdl}";

    programs.zellij = {
      enable = true;
      settings = {
        setup = "-l welcome";
        keybinds = {
          unbind = [
            "Ctrl q"
            "Ctrl h"
          ];
        };
      };
    };

    home.persistence = lib.mkIf osConfig.optinpermanence.enable {
      "/persist/home/${config.home.username}/zellij" = {
        directories = [ ".cache/zellij" ];
        allowOther = true;
      };
    };
  };
}
