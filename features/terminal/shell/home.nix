{
  lib,
  config,
  osConfig,
  ...
}:
let
  bashEnabled = {
    programs = {
      bash = {
        enable = true;
        enableCompletion = true;
        initExtra = ''
          . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
        '';
      };
      starship.enableBashIntegration = true;
    };
  };
  fishEnabled =
    lib.mkIf (builtins.elem config.home.username osConfig.features.terminal.fish.enableFor)
      {
        programs = {
          fish = {
            enable = true;
            interactiveShellInit = ''
              set fish_greeting # Disable greeting
            '';

          };
          starship.enableFishIntegration = true;
        };
      };
in
{
  config =
    lib.mkIf osConfig.features.terminal.enable {
      programs = {
        direnv = {
          enable = true;
          nix-direnv.enable = true;
        };
      };
    }
    // bashEnabled
    // fishEnabled;
}
