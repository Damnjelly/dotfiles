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
  ];
  home.persistence = lib.mkIf config.optinpermanence.enable {
    "/persist/home/${config.home.username}/Productivity" = {
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
