{ config, ... }: {
  config = {
    home = {
      file.".config/zellij/layouts/development.kdl".text =
        "${builtins.readFile ./development.kdl}";
    };
    stylix.targets.zellij.enable = true;
    programs.zellij = {
      enable = true;
      settings = {
        setup = "-l welcome";
        keybinds = { unbind = "Ctrl q"; };
      };
    };
    home.persistence."/persist/home/${config.home.username}/zellij" = {
      directories = [ ".cache/zellij" ];
      allowOther = true;
    };
  };
}
