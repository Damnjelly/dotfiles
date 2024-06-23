{
  lib,
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    inputs.stylix.homeManagerModules.stylix
    inputs.sops-nix.homeManagerModules.sops

    ./../../global-home.nix
    ./../../../users/gelei.nix

    ./../../../features/home-manager/cli
    ./../../../features/home-manager/creative
    ./../../../features/home-manager/discord/vesktop.nix
    ./../../../features/home-manager/games
    ./../../../features/home-manager/music
    ./../../../features/home-manager/email
    ./../../../features/home-manager/neomutt
    ./../../../features/home-manager/niri
    ./../../../features/home-manager/nixvim
    ./../../../features/home-manager/productivity
    ./../../../features/home-manager/qutebrowser
    ./../../../features/home-manager/shell
    ./../../../features/home-manager/sunbeam
    ./../../../features/home-manager/superfile
  ];

  config = {
    theme = "madotsuki";
    optinpermanence.enable = true;

    stylix.fonts = {
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
      sizes.terminal = 14;
    };

    programs.wpaperd = {
      enable = true;
      settings = {
        DP-1.path = "/home/${config.home.username}/.config/wpaperd/wallpapers/";
        DP-2.path = "/home/${config.home.username}/.config/wpaperd/wallpapers/";
        HDMI-A-1.path = "/home/${config.home.username}/.config/wpaperd/wallpapers/";
      };
    };

    sops = {
      secrets = {
        "nightglider/gelei/bitwardensession" = {
        };
      };
    };

    home.stateVersion = lib.mkDefault "23.11";
  };
}
