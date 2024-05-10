{ config, pkgs, inputs, outputs, lib, ... }: {
  options = with lib; {
    theme = mkOption {
      type = types.str;
      default = "madotsuki";
      example = "kanagawa";
    };
  };
  config = {
    stylix = {
      image = ./../features/themes/${config.theme}/wallpapers/wallpaper.png;
      base16Scheme = ./../features/themes/${config.theme}/scheme.yaml;

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
      autoEnable = true;
      homeManagerIntegration.followSystem = false;
    };

    home-manager = {
      extraSpecialArgs = { inherit inputs outputs; };
      backupFileExtension = "backup";
    };

    nixpkgs = {
    # You can add overlays here
      overlays = [
        outputs.overlays.additions
        outputs.overlays.modifications
        outputs.overlays.stable-packages
        outputs.overlays.mons-package
      ];
      # Configure your nixpkgs instance
      config = {
        # Disable if you don't want unfree packages
        allowUnfree = true;
        console = { earlySetup = true; };
      };
    };
  };
}
