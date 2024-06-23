{ pkgs, ... }:
{
  home.packages = with pkgs; [ glow ];
  xdg = {
    configFile."glow/glow.yml".source = ./glow.yml;
    configFile."glow/dracula.json".source = ./dracula.json;
    configFile."glow/email.json".source = ./email.json;
  };
}
