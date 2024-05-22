# # This file defines overlays
{ inputs, ... }: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs { pkgs = final; };

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    sunbeam = prev.sunbeam.overrideAttrs (old: {
      src = final.fetchFromGitHub {
        owner = "Damnjelly";
        repo = "sunbeam";
        rev = "1d50bf5af3714473cfa716f0aae5cb3ad91f494d";
        hash = "sha256-LJWQESmsM+VzO4cRjTB8/Hiv4v7cbEMjZvltVLwGif0=";
      };
    });
    j4-dmenu-desktop = prev.j4-dmenu-desktop.overrideAttrs (old: {
      version = "develop feb 2024";
      src = final.fetchFromGitHub {
        owner = "enkore";
        repo = "j4-dmenu-desktop";
        rev = "bc58c2a3740817a9283b646c6374ebadbd27bf5e";
        hash = "sha256-lm6QAOL1dm7aXxS2faK7od7vK15blidHc8u5C5rCDqw=";
      };
    });
    vesktop = prev.vesktop.overrideAttrs (old: {
      desktopItems = [
        (final.makeDesktopItem {
          name = "vesktop";
          desktopName = "Vesktop";
          exec =
            "niri msg action spawn -- vesktop %U --enable-features=UseOzonePlatform --ozone-platform=wayland";
          icon = "vesktop";
          startupWMClass = "Vesktop";
          genericName = "Internet Messenger";
          keywords = [ "discord" "vencord" "electron" "chat" ];
          categories = [ "Network" "InstantMessaging" "Chat" ];
        })
      ];
    });
    runelite = prev.runelite.overrideAttrs (old: {
      desktop = final.makeDesktopItem {
        name = "RuneLite";
        type = "Application";
        exec = "\\$SCRIPT_XWAYLAND runelite 1803 1006";
        icon = "runelite";
        comment = "Open source Old School RuneScape client";
        desktopName = "RuneLite";
        genericName = "Osrs";
        categories = [ "Game" ];
      };
    });
    obsidian = prev.obsidian.overrideAttrs (old: {
      desktopItem = final.makeDesktopItem {
        name = "obsidian";
        desktopName = "Obsidian";
        comment = "Knowledge base";
        icon = "obsidian";
        exec = "obsidian --disable-gpu";
        categories = [ "Office" ];
        mimeTypes = [ "x-scheme-handler/obsidian" ];
      };
    });
    #   niri-unstable = prev.niri-unstable.overrideAttrs (old: {
    #     src = final.fetchFromGitHub {
    #       owner = "Damnjelly";
    #       repo = "niri";
    #       rev = "779327a9ec8b7fac8780d9733fac4dc1c3cbb5f8";
    #       hash = "sha256-ccWQB+7URPYC0N0Jbzoi2cTjECSr42UsA2kKTOHe2oo=";
    #     };
    #   });
  };
  # When applied, the stable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.stable'
  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
  mons-package = final: prev: {
    monspkgs = import inputs.nixpkgs-mons { system = final.system; };
  };
}
