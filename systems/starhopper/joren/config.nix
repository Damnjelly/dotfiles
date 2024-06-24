{ config, ... }:
{
  wsl.defaultUser = "joren";
  home-manager.users.joren = import ./home.nix;

  # sops
  #  environment.sessionVariables = rec {
  #    HOME_WIN = /mnt/c/Users/joren;
  #    SOPS_AGE_KEY_FILE = "${HOME_WIN}/Documents/keys.txt";
  #  };
  sops = {
    age.keyFile = /mnt/c/Users/joren/Documents/keys.txt;
    secrets = {
      "desktop/gelei/pcpassword".neededForUsers = true;
      "desktop/gelei/githubprivatessh" = {
        owner = "joren";
        path = "/mnt/c/Users/joren/Documents/id_ed25519";
      };
    };
  };
}
