{ pkgs, lib, config, ... }: {
  home.packages = with pkgs; [ teams-for-linux remmina thunderbird gnome.gnome-calendar gnome.geary ];
  home.persistence = lib.mkIf config.optinpermanence.enable {
    "/persist/home/${config.home.username}/Productivity" = {
      directories = [ ".config/teams-for-linux" ".thunderbird" ];
      allowOther = true;
    };
  };
}
