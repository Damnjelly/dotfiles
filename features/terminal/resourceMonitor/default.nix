{ lib, osConfig, ... }:
{
  programs.btop = lib.mkIf osConfig.features.terminal.enable {
    enable = true;
    settings = {
      theme_background = false;
    };
  };
}
