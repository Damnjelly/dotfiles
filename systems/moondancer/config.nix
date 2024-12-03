{ config, lib, ... }:
{
  # System name
  networking.hostName = "moondancer";

  # System theme
  theme.name = "madotsuki";

  features = {
    # System features
    tailscale.enable = true;
    shares.enable = true;
    ssh.enable = true;

    # Server features
    immich = {
      enable = true;
    };

    games.servers = {
      #minecraft = {
      #  enable = true;
      #  projectArchitect2.enable = true;
      #};

      satisfactory = {
        enable = true;
        maxPlayers = 7;
        address = config.networking.defaultGateway.address;
      };
    };

    # Shared features
    neovim = {
      enable = true;
      enableFor = [ "gelei" ];
    };

    terminal = {
      enable = true;
      fish = {
        enable = true;
        enableFor = [ "gelei" ];
      };
    };
  };

  # User features
  users.gelei = {
    enable = true;
  };

  # Secrets keyfile location
  sops.age.keyFile = /etc/secrets/keys.txt;

  # Nix config path
  environment.sessionVariables.FLAKE = "/etc/nixos/";

  # System specific configuration
  services = {
    greetd.enable = lib.mkForce false;
    kmscon.enable = true;
    logind = {
      lidSwitch = "ignore";
      lidSwitchDocked = "ignore";
    };

    openssh = {
      enable = true;
      ports = [ 145 ];
      settings = {
        PasswordAuthentication = true;
        AllowUsers = [ "gelei" ];
        UseDns = true;
        X11Forwarding = false;
        PermitRootLogin = "prohibit-password";
      };
    };
  };

  system.stateVersion = "24.05";
}
