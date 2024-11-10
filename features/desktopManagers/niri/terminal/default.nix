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
        programs.rio = {
          # Looks interesting but is not ready yet
          enable = false;
          settings = {
            padding-x = 16;
            padding-y = [
              16
              16
            ];
            fonts.size = lib.mkForce 20;
            renderer = {
              performance = "High";
              backend = "GL";
              disable-unfocused-render = false;
            };
          };
        };
      };
}
