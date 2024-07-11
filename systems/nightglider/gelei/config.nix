{ config, ... }:
{
  users.users.gelei = {
    hashedPasswordFile = config.sops.secrets."nightglider/gelei/pcpassword".path;
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMZmrHtTrK7xz3DGGgZH9vaC0ZKpWKo4UqD3I2nmudaC joren122@hotmail.com"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOHJoxkGYT0jRB0apuYSPZx9JmRiK0u1d+4qy4NuVnP9 gelei@nightglider"
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
      "nightglider/gelei/galaxyprivatessh" = {
        owner = "gelei";
        path = "/home/gelei/.ssh/galaxy";
      };
      "nightglider/tailscale" = { };
    };
  };
}
