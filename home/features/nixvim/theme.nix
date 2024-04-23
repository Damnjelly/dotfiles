{ config, ... }: {
  programs.nixvim = {
    plugins.cmp.settings.window.completion.border = "single";
    colorschemes.kanagawa = {
      enable = true;
      settings = {
        colors = {
          palette = with config.lib.stylix.colors; {
            # Bg Shades
            sumiInk0 = "#1c0d17";
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
            winterYellow = "#0b360b";
            winterRed = "#3e111c";
            winterBlue = "#42445e";
            autumnGreen = "#56742c";
            autumnRed = "#C34043";
            autumnYellow = "#ae9763";

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
            oniViolet2 = "#8286ba";
            crystalBlue = "#86a2bc";
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
