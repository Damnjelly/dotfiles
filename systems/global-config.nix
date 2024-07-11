{
  inputs,
  outputs,
  lib,
  ...
}:
{
  options = with lib; {
    optinpermanence.enable = mkOption {
      type = types.bool;
      default = false;
      description = "enable permanence";
    };
  };
  config = {
    programs.dconf.enable = true;

    security.rtkit.enable = true;

    sops = {
      defaultSopsFile = ./../secrets/secrets.yaml;
      defaultSopsFormat = "yaml";
    };

    services = {
      xserver = {
        xkb = {
          layout = "us";
          variant = "";
        };
        display = 1;
      };
      # Enable remote destop
      xrdp = {
        enable = true;
      };

      # Enable CUPS to print documents.
      printing.enable = false;

      # Enable sound with pipewire.
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        extraConfig.pipewire."92-low-latency" = {
          context.properties = {
            default.clock.rate = 48000;
            default.clock.quantum = 32;
            default.clock.min-quantum = 32;
            default.clock.max-quantum = 32;
          };
        };
      };
    };

    home-manager = {
      extraSpecialArgs = {
        inherit inputs outputs;
      };
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
        console = {
          earlySetup = true;
        };
      };
    };
    
    # Enable bluetooth
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    programs.gnome-disks.enable = true;
    services = {
      devmon.enable = true;
      gvfs.enable = true;
      udisks2 = {
        mountOnMedia = true;
        enable = true;
      };
      blueman.enable = true;
    };

    nix.settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
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
