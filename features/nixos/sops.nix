{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ sops ];
  sops = {
    defaultSopsFile = ./../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    age.keyFile = /persist/sops/ags/keys.txt;

    secrets = { "desktop/gelei/pcpassword".neededForUsers = true; };
  };
}
