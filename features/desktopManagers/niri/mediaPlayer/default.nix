{
  pkgs,
  config,
  osConfig,
  ...
}:
{
  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [ modernx ];
    config = with config.lib.stylix.colors.withHashtag; {
      sub-font = config.stylix.fonts.monospace.name;
      sub-font-size = 22;
      sub-border-size = 1;
      sub-color = base05;
      sub-shadow = 3;
      sub-shadow-color = base00;
      sub-shadow-offset = 2;
    };
  };
}
