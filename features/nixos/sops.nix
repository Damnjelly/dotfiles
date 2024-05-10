{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ sops ];
  sops = {
    defaultSopsFile = ./../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
  };
}
