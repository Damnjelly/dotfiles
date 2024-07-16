{ pkgs, lib, config, ... }:
{
  home ={
    packages = with pkgs; [ openrct2 ];
    persistence = lib.mkIf config.optinpermanence.enable {
      "/persist/home/${config.home.username}/OpenRCT2" = {
        directories = [ ".config/OpenRCT2" ];
        allowOther = true;
      };
    };
  };
}
