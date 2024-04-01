{
  config,
  pkgs,
  ...
}: let
  scheme = "kanagawa";
in {
  stylix = {
    image = ./wallpaper.png;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/${scheme}.yaml";

    fonts = {
      monospace = {
        package = pkgs.nerdfonts;
        name = "Commit Mono";
      };

      serif = config.stylix.fonts.monospace;
      sansSerif = config.stylix.fonts.monospace;
      emoji = config.stylix.fonts.monospace;
      sizes = {
        terminal = 14;
      };
    };

    cursor = {
      package = pkgs.hackneyed;
      name = "Hackneyed";
      size = 16;
    };

    targets = {
      #firefox = {
      #  enable = true;
      #  profileNames = ["gelei"];
      #};

      gtk.enable = true;
      kitty.enable = true;
      yazi.enable = true;
      hyprland.enable = true;
      foot.enable = true;
      fzf.enable = true;
      rofi.enable = true;
      nixvim.enable = true;
      zellij.enable = true;
    };
  };
}
