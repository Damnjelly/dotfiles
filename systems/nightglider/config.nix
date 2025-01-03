{ config, ... }:
{
  # System name
  networking.hostName = "nightglider";

  # System theme
  theme.name = "madotsuki";

  optinpermanence.enable = true;

  features = {
    # System features
    tailscale.enable = true;
    shares.enable = true;
    ssh.enable = true;

    # Shared features
    desktopManagers = {
      niri = {
        enable = true;
        enableFor = [ "gelei" ];
      };
    };

    terminal = {
      enable = true;
      fish = {
        enable = true;
        enableFor = [ "gelei" ];
      };
    };

    neovim = {
      enable = true;
      enableFor = [ "gelei" ];
    };

    games = {
      enable = true;
      enableFor = [ "gelei" ];
    };
  };

  users.gelei = {
    enable = true;

    features = {
      productivity.enable = true;
      email.enable = true;
      neomutt.enable = true;
      discord.enable = true;
      music.enable = true;
    };
  };

  environment.persistence."/persist/system" = {
    hideMounts = true;
    directories = [
      "/var/lib/mpd"
    ];
  };
  # Secrets keyfile location
  sops.age.keyFile = "/persist/sops/age/keys.txt";

  # Nix config path
  environment.sessionVariables = {
    SOPS_AGE_KEY_FILE = config.sops.age.keyFile;
    FLAKE = "/etc/nixos/";
  };

  networking.firewall.allowedTCPPorts = [ 6600 ];
  networking.firewall.allowedUDPPorts = [ 6600 ];

  system.stateVersion = "23.11";
}
