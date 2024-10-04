{
  config,
  lib,
  ...
}:
let
  cfg = config.features.games;
in
{
  options = with lib; {
    features.games = {
      enable = mkEnableOption "games";
      enableFor = mkOption {
        type = with types; listOf str;
        default = [ ];
      };
    };
  };

  imports = [
    ./steam/system.nix
    ./osu/system.nix
    ./servers
  ];

  # Enable games module only when enabled and a user is assigned
  config = lib.mkIf (cfg.enable && cfg.enableFor != null) {
    services.xserver = {
      displayManager.startx.enable = true;
      desktopManager.xfce.enable = true;
    };
  };
}
