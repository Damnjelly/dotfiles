{
  pkgs,
  lib,
  config,
  ...
}:
{
  home.packages = with pkgs; [
    teams-for-linux
    remmina
    citrix_workspace
    jetbrains.idea-community
    onlyoffice-bin_latest

    corefonts
    inter
  ];

  fonts.fontconfig.enable = true;

  home.persistence = lib.mkIf config.optinpermanence.enable {
    "/persist/home/${config.home.username}/productivity" = {
      directories = [
        ".config/teams-for-linux"
        ".thunderbird"
        ".config/JetBrains"
        ".local/share/JetBrains"
      ];
      allowOther = true;
    };
  };
}
