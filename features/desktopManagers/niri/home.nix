{
  lib,
  config,
  osConfig,
  ...
}:
{

  imports = [
    ./appLauncher
    ./browser
    ./fileBrowser
    ./lockScreen
    ./mediaPlayer
    #./shell
    ./terminal
    ./windowManager/home.nix
  ];

  config = lib.mkIf (builtins.elem config.home.username osConfig.features.desktopManagers.niri.enableFor) {
    programs = {
      rbw.enable = true;
      rofi.enable = true;
    };
  };
}
