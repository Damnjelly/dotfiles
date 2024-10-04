{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}:
{
  options.features.productivity.enable = lib.mkEnableOption "productivity";

  config.home = lib.mkIf config.features.productivity.enable {
    packages = with pkgs; [
      citrix_workspace
      onlyoffice-bin_latest
      teams-for-linux
    ];

    persistence = lib.mkIf osConfig.optinpermanence.enable {
      "/persist/home/${config.home.username}/productivity" = {
        directories = [
          ".config/JetBrains"
          ".config/teams-for-linux"
          ".local/share/JetBrains"
          ".ICAClient"
        ];
        allowOther = true;
      };
    };
  };
}
