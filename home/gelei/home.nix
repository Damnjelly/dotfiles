# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ config, pkgs, ...}: {
  imports = [
    ./features/cli
    ./features/firefox/firefox.nix
    ./features/hyprland
    ./features/nixvim
    ./features/vesktop.nix
  ];
  # General theming
  stylix = {
    image = ./wallpaper.png;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";
               # To choose a theme, edit the text above ^ to any of https://github.com/tinted-theming/base16-schemes
               
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
      gtk.enable = true;
      fzf.enable = true; # TODO: Create separate nix file with theming
      rofi.enable = true; # TODO: Either replace or create separate nix with theming
      zathura.enable = true;
    };
  };
  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for httpr://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "gelei";
    homeDirectory = "/home/gelei";
  };

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
