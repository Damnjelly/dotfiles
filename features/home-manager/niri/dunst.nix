{ lib, config, ... }:
{
  stylix.targets.dunst.enable = false;
  services.dunst = {
    enable = true;
    settings = {
      global = with config.lib.stylix.colors; {
        font = lib.mkForce "Kirsch2x 12";
        monitor = "DP-1";
        offset = "0x0";
        origin = "top-right";

        padding = 2;
        background = "#${base03}";
        foreground = "#${base05}";
        frame_width = 0;
      };
    };
  };
}
