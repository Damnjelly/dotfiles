{ config, ... }:
{
  imports = [ ./host.nix ];
  users.users.gelei = {
    hashedPasswordFile = config.sops.secrets."nightglider/gelei/pcpassword".path;
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMZmrHtTrK7xz3DGGgZH9vaC0ZKpWKo4UqD3I2nmudaC joren122@hotmail.com"
    ];
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
  home-manager.users.gelei = import ./home.nix;

  # sops
  environment.sessionVariables.SOPS_AGE_KEY_FILE = /persist/sops/ags/keys.txt;
  sops = {
    age.keyFile = /persist/sops/ags/keys.txt;
    secrets = {
      "nightglider/gelei/pcpassword".neededForUsers = true;
      "nightglider/gelei/githubprivatessh" = {
        owner = "gelei";
        path = "/home/gelei/.ssh/id_ed25519";
      };
      "nightglider/tailscale" = { };
    };
  };
}
