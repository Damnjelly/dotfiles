# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ config, pkgs, outputs, inputs, ... }: {
  imports = [ 
   outputs.homeManagerModules.sunbeam
   inputs.nixvim.homeManagerModules.nixvim 
   inputs.stylix.homeManagerModules.stylix
    ./features/cli 
    ./features/firefox/firefox.nix 
    ./features/hyprland 
    ./features/nixvim 
    ./features/vesktop.nix 
    ./features/sunbeam
  ];
  # General theming
  stylix = {
    image = ./wallpaper.png;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";
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
