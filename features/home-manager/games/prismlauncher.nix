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
      "/persist/home/${config.home.username}/primslauncher" = {
        directories = [ ".local/share/PrismLauncher" ];
        allowOther = true;
      };
    };
  };
}
