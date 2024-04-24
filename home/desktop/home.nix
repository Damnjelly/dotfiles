# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ config, pkgs, outputs, inputs, lib, ... }:
let
  customtheme = pkgs.writeTextFile {
    name = "theme.yaml";
    text = "${builtins.readFile ./../themes/madotsuki.yaml}";
    destination = "/theme/theme.yaml";
  };
in {
  imports = [
    outputs.homeManagerModules.sunbeam
    inputs.nixvim.homeManagerModules.nixvim
    inputs.stylix.homeManagerModules.stylix
    inputs.niri.homeModules.niri
    ./../../features/home-manager/cli
    ./../../features/home-manager/firefox/firefox.nix
    ./../../features/home-manager/hyprland
    ./../../features/home-manager/nixvim
    ./../../features/home-manager/vesktop.nix
    ./../../features/home-manager/sunbeam
    ./../../features/home-manager/niri
    ./../../features/home-manager/games
    ./../../features/home-manager/shell
  ];
  options = {
    colorscheme = lib.mkOption {
      type = lib.types.str;
      default = "kanagawa";
      example = "rose-pine";
    };
  };
  config = {
    # General theming
    stylix = {
      image = ./madotsuki.png;

      #base16Scheme = "${pkgs.base16-schemes}/share/themes/${config.colorscheme}.yaml";
      base16Scheme = "${customtheme}/theme/theme.yaml";
      # To choose a theme, edit the text above ^ to any of https://github.com/tinted-theming/base16-schemes

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
      targets = {
        gtk.enable = true;
        fzf.enable = true; # TODO: Create separate nix file with theming
        zathura.enable = true;
      };
    };
    nixpkgs = {
      overlays = builtins.attrValues outputs.overlays;
      config = {
        allowUnfree = true;
        allowUnfreePredicate = _: true;
      };
    };
    pam.sessionVariables = {
      SSH_AUTH_SOCK = "${builtins.getEnv "XDG_RUNTIME_DIR"}/ssh-agent.socket";
    };

    home = {
      username = "gelei";

      # the stupid override won't work so i'm making a separate desktop file
      file.".local/share/applications/steam-gamescope.desktop".text = ''
        [Desktop Entry]
        Name=Runelite Wayland
        Exec=$SCRIPT_XWAYLAND runelite 1803 1006
        Type=Application
      '';
     homeDirectory = "/home/gelei";
    };

    # Enable home-manager and git
    programs.home-manager.enable = true;
    programs.git.enable = true;

    # Nicely reload system units when changing configs
    systemd.user.startServices = "sd-switch";

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    home.stateVersion = "23.11";
  };
}
