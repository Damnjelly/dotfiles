{ pkgs, inputs, ... }:
{
  imports = [ ./g4music.nix inputs.nyaa.homeManagerModule ];
  home.packages = with pkgs; [
    g4music
    tagger
    clematis
    gnome.adwaita-icon-theme
    fragments
  ];
  programs.nyaa = {
    enable = true;
    scroll_padding = 6;
    download_client = "RunCommand";
    client.cmd = {
      cmd = "fragments {torrent}";
      shell_cmd = "sh -c";
    };
  };
}
