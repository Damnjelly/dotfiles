{
  config,
  lib,
  ...
}:
let
  cfg = config.features.neovim;
in
{
  options = with lib; {
    features.neovim = {
      enable = mkEnableOption "neovim";
      enableFor = mkOption {
        type = with types; listOf str;
        default = [ ];
      };
    };
  };

  imports = [
    ./keymaps/system.nix
  ];

  # Enable nixvim only when enabled and a user is assigned
  config = lib.mkIf (cfg.enable && cfg.enableFor != null) {
    services.kanata.enable = true;
  };
}
