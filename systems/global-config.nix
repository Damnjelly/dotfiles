{
  pkgs,
  inputs,
  outputs,
  lib,
  config,
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
  imports = [ inputs.impermanence.nixosModules.impermanence ];
  config = {
    boot.initrd = lib.mkIf config.optinpermanence.enable {
      postDeviceCommands = lib.mkAfter ''
        mkdir /btrfs_tmp
        mount /dev/root_vg/root /btrfs_tmp
        if [[ -e /btrfs_tmp/root ]]; then
        mkdir -p /btrfs_tmp/old_roots
        timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
        mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
        fi

        delete_subvolume_recursively() {
          IFS=$'\n'
          for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
          delete_subvolume_recursively "/btrfs_tmp/$i"
          done
          btrfs subvolume delete "$1"
        }

        for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
        delete_subvolume_recursively "$i"
        done

        btrfs subvolume create /btrfs_tmp/root
        umount /btrfs_tmp
      '';
    };

    systemd.tmpfiles = {
      rules = lib.mkIf config.optinpermanence.enable [
        "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
        "d /persist/home/ 0777 root root-"
        "d /persist/home/gelei/ 0700 gelei users-"
      ];
    };
    programs.dconf.enable = true;

    security.rtkit.enable = true;

    sops = {
      defaultSopsFile = ./../secrets/secrets.yaml;
      defaultSopsFormat = "yaml";
    };

    environment.sessionVariables.FLAKE = "/etc/nixos/";

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
