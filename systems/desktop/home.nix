# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ outputs, inputs, ... }: {
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
    ./theme.nix
  ];
  config = {
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
      
      # the stupid override won't work so i'm making a separate desktop file
      file.".local/share/applications/steam-gamescope.desktop".text = ''
        [Desktop Entry]
        Name=Runelite Wayland
        Exec=$SCRIPT_XWAYLAND runelite 1803 1006
        Type=Application
      '';
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
