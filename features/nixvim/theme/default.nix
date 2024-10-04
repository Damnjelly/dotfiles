{ config, ... }:
{
  programs.nixvim = {
    plugins.cmp.settings.window.completion.border = "rounded";
    colorschemes.kanagawa = {
      enable = true;
      settings = {
        colors = {
          palette = with config.lib.stylix.colors; {
            # Bg Shades
            sumiInk0 = "#${base01}";
            sumiInk1 = "#${base01}";
            sumiInk2 = "#261727";
            sumiInk3 = "#${base00}";
            sumiInk4 = "#${base02}";
            sumiInk5 = "#${base03}";
            sumiInk6 = "#${base04}"; # fg

            # Popup and Floats
            waveBlue1 = "#443555";
            waveBlue2 = "#8467a6";

            # Diff and Git
            winterGreen = "#2f4240";
            winterYellow = "#${base0C}";
            winterRed = "#${base08}";
            winterBlue = "#${base07}";
            autumnGreen = "#${base0B}";
            autumnRed = "#${base09}";
            autumnYellow = "#${base0A}";

            # Diag
            samuraiRed = "#e81623";
            roninYellow = "#FF9E3B";
            waveAqua1 = "#${base0C}";
            dragonBlue = "#658594";

            # Fg and Comments
            oldWhite = "#8f677a";
            fujiWhite = "#${base06}";
            fujiGray = "#634f59";

            oniViolet = "#${base0E}";
            oniViolet2 = "#${base07}";
            crystalBlue = "#${base05}";
            springViolet1 = "#281c2c";
            springViolet2 = "#${base08}";
            springBlue = "#b94562";

            springGreen = "#${base0B}";
            boatYellow1 = "#${base07}";
            boatYellow2 = "#${base0D}";
            carpYellow = "#${base05}";

            sakuraPink = "#${base0F}";
            waveRed = "#b94562";
            peachRed = "#${base09}";
            surimiOrange = "#FFA066";
            katanaGray = "#717C7C";
          };
        };
      };
    };
  };
}
