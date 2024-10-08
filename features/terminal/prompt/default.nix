{
  pkgs,
  config,
  osConfig,
  lib,
  ...
}:
{
  programs.starship =
    with config.lib.stylix.colors;
    lib.mkIf osConfig.features.terminal.enable {
      enable = true;
      package = pkgs.starship;
      settings = {
        username = {
          style_user = "#${base07} bold";
          style_root = "#${base08} bold";
          format = "[$user]($style) ";
          disabled = false;
          show_always = true;
        };
        hostname = {
          ssh_only = false;
          ssh_symbol = "🌐 ";
          format = "on [$hostname](bold #${base08}) ";
          trim_at = ".local";
          disabled = false;
        };
      };
    };
}
