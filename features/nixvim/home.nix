{ lib, config, osConfig, ... }: {

  imports = [
    ./keymaps/home.nix
    ./plugins
    ./settings
    ./theme
  ];

  config = lib.mkIf (builtins.elem config.home.username osConfig.features.neovim.enableFor) {
    programs.nixvim.enable = true;
  };
}
