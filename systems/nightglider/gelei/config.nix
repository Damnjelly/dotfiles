{ pkgs, config, ... }:
{
  users.users.gelei = {
    hashedPasswordFile = config.sops.secrets."nightglider/gelei/pcpassword".path;
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP3oaeGTbuDpOp3ebDPmUxjV1W1sI1EzXkqxJOJCNknf juinen@proton.me
"
    ];
    extraGroups = [
      "networkmanager"
      "wheel"
      "gamemode"
    ];
  };
  home-manager.users.gelei = import ./home.nix;

  nix.settings = {
    substituters = [ "https://nix-gaming.cachix.org" ];
    trusted-public-keys = [ "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" ];
  };

  hardware = {
    # Enable opentabletdriver
    opentabletdriver.enable = true;
    uinput.enable = true;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  security.polkit.enable = true;

  programs = {
    steam.enable = true;

    gamemode = {
      enable = true;
      settings = {
        general = {
          renice = 10;
        };

        # Warning: GPU optimisations have the potential to damage hardware
        gpu = {
          apply_gpu_optimisations = "accept-responsibility";
          gpu_device = 1;
          amd_performance_level = "high";
        };

        custom = {
          start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
          end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
        };
      };
    };
  };

  services.udev.packages = with pkgs; [ game-devices-udev-rules ];

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gnome
        xdg-desktop-portal-gtk
      ];
      configPackages = with pkgs; [ gnome-session ];
    };
  };

  # sops
  environment.sessionVariables.SOPS_AGE_KEY_FILE = /persist/sops/ags/keys.txt;
  sops = {
    age.keyFile = /persist/sops/ags/keys.txt;
    secrets = {
      "nightglider/gelei/pcpassword".neededForUsers = true;
      "nightglider/gelei/sshjuinened22519" = {
        owner = "gelei";
        path = "/home/gelei/.ssh/id_ed25519";
      };
      "nightglider/tailscale" = { };
    };
  };
}
