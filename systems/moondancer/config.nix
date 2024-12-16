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

    tutter.enable = true;

    # Server features
    immich = {
      enable = false;
    };

    games.servers = {
      satisfactory = {
        enable = false;
        maxPlayers = 8;
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
  sops.age.keyFile = "/etc/secrets/keys.txt";

  environment.sessionVariables = {
    SOPS_AGE_KEY_FILE = config.sops.age.keyFile;
    FLAKE = "/etc/nixos/";
  };

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
