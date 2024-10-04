{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}:
{
  config =
    lib.mkIf (builtins.elem config.home.username osConfig.features.desktopManagers.niri.enableFor)
      {
        xdg.configFile."xdg-terminals.list".text = "${pkgs.foot}/bin/foot";
        stylix.targets.foot.enable = true;
        programs.foot = {
          enable = true;
          settings.main = {
            pad = "16x11center";
            term = "xterm-direct";
          };
        };
      };
}
