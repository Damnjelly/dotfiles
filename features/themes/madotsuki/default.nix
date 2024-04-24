{ pkgs, lib, config, ... }:
let
  customtheme = pkgs.writeTextFile {
    name = "theme.yaml";
    text = "${builtins.readFile ./madotsuki.yaml}";
    destination = "/theme/theme.yaml";
  };
in {
  stylix = {
    image = ./madotsuki.png;
    base16Scheme = "${customtheme}/theme/theme.yaml";
    # To choose a theme, edit the text above ^ to any of https://github.com/tinted-theming/base16-schemes

    fonts = {
      monospace = {
        package = pkgs.hack-font;
        name = "Hack";
      };

      serif = config.stylix.fonts.monospace;
      sansSerif = config.stylix.fonts.monospace;
      emoji = config.stylix.fonts.monospace;
      sizes = { terminal = 14; };
    };

    cursor = {
      package = pkgs.hackneyed;
      name = "Hackneyed";
      size = 16;
    };

    # theme specific overrides might have to become a separate nix file
    programs = {
      foot.settings = { main = { font = lib.mkForce "Kirsch2x:size=20"; }; };
    };
  };
}
