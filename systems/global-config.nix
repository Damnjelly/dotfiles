{ config, pkgs, inputs, outputs, lib, ... }: {
  options = with lib; {
    theme = mkOption {
      type = types.str;
      default = "madotsuki";
      example = "kanagawa";
    };
    optinpermanence.enable = mkOption {
      type = types.bool;
      default = false;
      description = "enable permanence";
    };
  };
  config = {
    stylix = {
      image = ./../features/themes/${config.theme}/wallpapers/wallpaper.png;
      base16Scheme = ./../features/themes/${config.theme}/scheme.yaml;

      fonts = {
        monospace = {
          package = pkgs.cascadia-code;
          name = "Cascadia Code NF";
        };

        serif = {
          package = pkgs.cascadia-code;
          name = "Cascadia Mono NF";
        };

        sansSerif = config.stylix.fonts.serif;
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

    # Set your time zone.
    time.timeZone = "Europe/Amsterdam";

    # Select internationalisation properties.
    i18n = {
      defaultLocale = "en_US.UTF-8";
      extraLocaleSettings = {
        LC_ADDRESS = "nl_NL.UTF-8";
        LC_IDENTIFICATION = "nl_NL.UTF-8";
        LC_MEASUREMENT = "nl_NL.UTF-8";
        LC_MONETARY = "nl_NL.UTF-8";
        LC_NAME = "nl_NL.UTF-8";
        LC_NUMERIC = "nl_NL.UTF-8";
        LC_PAPER = "nl_NL.UTF-8";
        LC_TELEPHONE = "nl_NL.UTF-8";
        LC_TIME = "nl_NL.UTF-8";
      };
    };
  };
}
