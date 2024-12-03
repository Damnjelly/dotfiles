{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.features.games;
in

with lib;

{
  options.users.users = mkOption {
    type = types.attrsOf (
      types.submodule ({
        extraGroups = [ "gamemode" ];
      })
    );
  };
  config = mkIf (cfg.enable && cfg.enableFor != null) {
    programs = {
      steam = {
        enable = true;
        remotePlay.openFirewall = true;
      };

      gamemode = {
        enable = true;
        settings = {
          general = {
            renice = 10;
          };

          # Warning: GPU optimisations have the potential to damage hardware
          gpu = {
            apply_gpu_optimisations = "accept-responsibility";
            gpu_device = 1;
            amd_performance_level = "high";
          };

          custom = {
            start = "${pkgs.notify}/bin/notify-send 'GameMode started'";
            end = "${pkgs.notify}/bin/notify-send 'GameMode ended'";
          };
        };
      };
    };

    networking.firewall.allowedTCPPorts = [ 27036 ];
    networking.firewall.allowedUDPPorts = [ 27036 ];

    services.udev.packages = with pkgs; [ game-devices-udev-rules ];
  };
}
