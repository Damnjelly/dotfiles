{ config, lib, ... }: {
  config = {
    home.file.".config/zellij/layouts/development.kdl".text =
      "${builtins.readFile ./development.kdl}";
    stylix.targets.zellij.enable = true;
    programs.zellij = {
      enable = true;
      settings = {
        setup = "-l welcome";
        keybinds = { unbind = "Ctrl q"; };
      };
    };
    home.persistence = lib.mkIf config.optinpermanence.enable {
      directories = [ ".cache/zellij" ];
      allowOther = true;
    };
  };
}
