{ pkgs
, lib
, config
, osConfig
, ...
}:
{
  config =
    lib.mkIf (builtins.elem config.home.username osConfig.features.desktopManagers.niri.enableFor)
      {
        xdg.configFile."xdg-terminals.list".text = "${pkgs.kitty}/bin/kitty";
        stylix.targets.foot.enable = true;
        home.packages = [ pkgs.kirsch ];
        programs.foot = {
          enable = false;
          settings.main = {
            pad = "16x11center";
            #term = "xterm-direct";
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
        programs.kitty = {
          enable = true;
          settings = {
            cursor_trail = 3;
            window_padding_width = "16 16 16 16";
          };
        };
      };
}
