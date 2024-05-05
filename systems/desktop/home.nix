# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ outputs, inputs, lib, config, ... }: {
  imports = [
    inputs.niri.homeModules.niri
    inputs.nixvim.homeManagerModules.nixvim
    inputs.impermanence.nixosModules.home-manager.impermanence
    outputs.homeManagerModules.sunbeam
    ./../../features/home-manager/cli
    ./../../features/home-manager/creative
    ./../../features/home-manager/discord/vesktop.nix
    ./../../features/home-manager/firefox/firefox.nix
    ./../../features/home-manager/games
    ./../../features/home-manager/niri
    ./../../features/home-manager/nixvim
    ./../../features/home-manager/shell
    ./../../features/home-manager/sunbeam
    ./../../features/home-manager/work
  ];
  config = {
    nixpkgs = {
      overlays = builtins.attrValues outputs.overlays;
      config = {
        allowUnfree = true;
        allowUnfreePredicate = _: true;
      };
    };
    home = {
      homeDirectory = lib.mkDefault "/home/gelei";
      username = lib.mkDefault "gelei";
      stateVersion = lib.mkDefault "23.11";
      sessionPath = [ "$HOME/.local/bin" ];

      persistence."/persist/home/${config.home.username}" = {
        directories = [
          "Downloads"
          "Music"
          "Pictures"
          "Documents"
          "Videos"
        ];
        allowOther = true;
      };
    };

    programs.git = {
      enable = true;
      userName = "Damnjelly";
      userEmail = "joren122@hotmail.com";
    };

    programs.ssh.addKeysToAgent = "yes";

    pam.sessionVariables = {
      SSH_AUTH_SOCK = "${builtins.getEnv "XDG_RUNTIME_DIR"}/ssh-agent.socket";
    };

    # Nicely reload system units when changing configs
    systemd.user.startServices = "sd-switch";
  };
}
