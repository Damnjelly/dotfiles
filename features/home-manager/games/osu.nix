{ lib, config, ... }: {
  home.persistence = lib.mkIf config.optinpermanence.enable {
    "/persist/home/${config.home.username}/osu-lazer" = {
      directories = [ ".local/share/osu" ];
      allowOther = true;
    };
  };
}
