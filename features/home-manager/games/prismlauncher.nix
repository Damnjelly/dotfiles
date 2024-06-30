{
  pkgs,
  lib,
  config,
  ...
}:
{
  home = {
    packages = with pkgs; [ prismlauncher ];
    persistence = lib.mkIf config.optinpermanence.enable {
      "/persist/home/${config.home.username}/Prismlauncher" = {
        directories = [ ".local/share/PrismLauncher" ];
        allowOther = true;
      };
    };
  };
}
