{ pkgs, config, ... }: {
  programs.starship = with config.lib.stylix.colors; {
    enable = true;
    package = pkgs.starship;
    settings = {
      username = {
        style_user = "#${base0D} bold";
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
