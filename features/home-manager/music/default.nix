{ pkgs, inputs, lib, config, ... }:
{
  imports = [
    inputs.nyaa.homeManagerModule
  ];
  home = {
    packages = with pkgs; [
      amberol
      tagger
      gnome.adwaita-icon-theme
      downonspot
      spotify
    ];
    persistence = lib.mkIf config.optinpermanence.enable {
      "/persist/home/${config.home.username}/music" = {
        directories = [ ".cache/amberol" ];
        allowOther = true;
      };
    };
    sessionVariables = {
      MUSIC = "amberol";
    };
  };
  # programs.nyaa = {
  #   enable = true;
  #   scroll_padding = 6;
  #   download_client = "RunCommand";
  #   client.cmd = {
  #     cmd = "fragments {torrent}";
  #     shell_cmd = "sh -c";
  #   };
  # };
}
