{ config, lib, ... }:
{
  config = {
    home.file.".config/zellij/layouts/development.kdl".text = "${builtins.readFile ./development.kdl}";
    programs.zellij = {
      enable = true;
      settings = {
        setup = "-l welcome";
        keybinds = {
          unbind =  [
            "Ctrl q"
            "Ctrl h"
          ];
        };
      };
    };
    home.persistence = lib.mkIf config.optinpermanence.enable {
      "/persist/home/${config.home.username}/Zellij" = {
        directories = [ ".cache/zellij" ];
        allowOther = true;
      };
    };
  };
}
