{
  inputs,
  config,
  lib,
  ...
}:
let
  # In secrets file, create a hashed password underneath hostname: username: pcpassword
  username = "gelei";
in
{
  config = lib.mkIf config.users.${username}.enable {
    users.users.${username} = {
      hashedPasswordFile =
        config.sops.secrets."${config.networking.hostName}/${username}/pcpassword".path;
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP3oaeGTbuDpOp3ebDPmUxjV1W1sI1EzXkqxJOJCNknf juinen@proton.me"
      ];
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
    };

    sops = {
      secrets = {
        "${config.networking.hostName}/${username}/pcpassword".neededForUsers = true;
        "${config.networking.hostName}/${username}/sshjuinened22519" = {
          owner = "${username}";
          path = "home/${username}/.ssh/id_ed25519";
        };
      };
    };

    home-manager.users.${username} =
      {
        osConfig,
        inputs,
        ...
      }:
      let
        # In secrets file, create a hashed password underneath hostname: username: pcpassword
        username = "gelei";
      in
      {
        home = {
          sessionPath = [ "$HOME/.local/bin" ];
        };

        programs.git = {
          userName = "Damnjelly";
          userEmail = "juinen@proton.me";
        };

        # Extend user with features selected in system
        features = { } // osConfig.users.${username}.features;
      };
  };
}
