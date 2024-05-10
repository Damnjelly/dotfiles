{ inputs, outputs, config, ... }: {
  imports = [
    inputs.sops-nix.nixosModules.sops
    ./../global-config.nix
  ];
  users.users.gelei = {
    initialPassword = "12345";
    hashedPasswordFile = config.sops.secrets."desktop/gelei/pcpassword".path;
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMZmrHtTrK7xz3DGGgZH9vaC0ZKpWKo4UqD3I2nmudaC joren122@hotmail.com"
    ];
    extraGroups = [ "networkmanager" "wheel" ];
  };
  environment.sessionVariables.SOPS_AGE_KEY_FILE = /persist/sops/ags/keys.txt;
  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users.gelei = import ./../../users/gelei/home.nix;
    backupFileExtension = "backup";
  };
}
