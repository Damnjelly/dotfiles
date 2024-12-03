{ lib, config, osConfig, ... }: {

  imports = [
    ./keymaps/home.nix
    ./plugins
    ./settings
    ./theme
  ];

  config = lib.mkIf (builtins.elem config.home.username osConfig.features.neovim.enableFor) {
    programs.nixvim.enable = true;

    home.sessionVariables.EDITOR = "nvim";
#   home.persistence = lib.mkIf osConfig.optinpermanence.enable {
#     "/persist/home/${config.home.username}/nvim" = {
#       directories = [ ".cache/nvim" ];
#       allowOther = false;
#     };
#   };
  };
}
