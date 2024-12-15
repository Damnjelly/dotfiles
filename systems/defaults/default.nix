{ outputs
, pkgs
, ...
}:
{
  config = {
    environment.systemPackages = with pkgs; [
      git
      nh
      comma
      sops
      vim
      wget
    ];

    sops = {
      defaultSopsFile = ../../secrets/secrets.yaml;
      defaultSopsFormat = "yaml";
    };

    nix.settings = {
      warn-dirty = false;
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

    security.rtkit.enable = true;

    nixpkgs = {
      # You can add overlays here
      overlays = [
        outputs.overlays.additions
        outputs.overlays.modifications
        outputs.overlays.unstable-packages
      ];
      # Configure your nixpkgs instance
      config = {
        allowUnfree = true;
        console = {
          earlySetup = true;
        };
      };
    };
    # Enable sound with pipewire.
    services.pipewire = {
      enable = true;
      alsa.enable = true;
    };
    etc."rebuild" = # bash
      ''
        #!/usr/bin/env bash
        #
        # I believe there are a few ways to do this:
        #
        #    1. My current way, using a minimal /etc/nixos/configuration.nix that just imports my config from my home directory (see it in the gist)
        #    2. Symlinking to your own configuration.nix in your home directory (I think I tried and abandoned this and links made relative paths weird)
        #    3. My new favourite way: as @clot27 says, you can provide nixos-rebuild with a path to the config, allowing it to be entirely inside your dotfies, with zero bootstrapping of files required.
        #       `nixos-rebuild switch -I nixos-config=path/to/configuration.nix`
        #    4. If you uses a flake as your primary config, you can specify a path to `configuration.nix` in it and then `nixos-rebuild switch —flake` path/to/directory
        # As I hope was clear from the video, I am new to nixos, and there may be other, better, options, in which case I'd love to know them! (I'll update the gist if so)

        # A rebuild script that commits on a successful build
        set -e

        # Edit your config
        $EDITOR configuration.nix

        # cd to your config dir
        pushd $FLAKE

        # Early return if no changes were detected (thanks @singiamtel!)
        if git diff --quiet '*.nix'; then
            echo "No changes detected, exiting."
            popd
            exit 0
        fi

        # Autoformat your nix files
        nixfmt . &>/dev/null \
          || ( nixfmt . ; echo "formatting failed!" && exit 1)

        # Shows your changes
        git diff -U0 '*.nix'

        echo "NixOS Rebuilding..."

        # Rebuild, output simplified errors, log trackebacks
        nh os switch &>nixos-switch.log || (cat nixos-switch.log | grep --color error && exit 1)

        # Get current generation metadata
        current=$(nixos-rebuild list-generations | grep current)

        # Commit all changes witih the generation metadata
        git commit -am "$current"

        # Back to where you were
        popd

        # Notify all OK!
        notify-send -e "NixOS Rebuilt OK!" --icon=software-update-available
      '';
  };
}
