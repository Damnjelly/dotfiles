{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.terminal;
in
{
  options = with lib; {
    features.terminal = {
      enable = mkEnableOption "terminal";
      fish = {
        enable = mkEnableOption "fish";
        enableFor = mkOption {
          type = with types; listOf str;
          default = [ ];
        };
      };
      bash = {
        enable = mkEnableOption "bash";
        enableFor = mkOption {
          type = with types; listOf str;
          default = [ ];
        };
      };
    };
  };

  # Enable terminal features only when enabled and a user is assigned
  config = lib.mkIf cfg.enable {
    programs =
      if (cfg.fish.enable && cfg.fish.enableFor != null) then
        {
          fish.enable = true;
          bash = {
            interactiveShellInit = ''
              if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
              then
                shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
                exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
              fi
            '';
          };
        }
      else
        { };
  };
}
