{ pkgs, inputs, lib, config, ... }:
{
  imports = [
    inputs.nyaa.homeManagerModule
  ];
  home = {
    packages = with pkgs; [
      aberol
      tagger
      gnome.adwaita-icon-theme
    ];
    persistence = lib.mkIf config.optinpermanence.enable {
      "/persist/home/${config.home.username}/music" = {
        directories = [ ".cache/aberol" ];
        allowOther = true;
      };
    };
    sessionVariables = {
      MUSIC = "aberol";
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
