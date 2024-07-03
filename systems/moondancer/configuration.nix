{ inputs, config, ... }:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
    inputs.disko.nixosModules.default
    inputs.home-manager.nixosModules.home-manager

    ./hardware-configuration.nix
    ./gelei/config.nix
    ./../global-config.nix

    ./../../features/nixos/ssh.nix
    ./../../features/nixos/system-packages.nix
    ./../../features/nixos/tailscale.nix.nix
  ];

  # system name
  networking.hostName = "moondancer";

  services.openssh = {
    enable = true;
    ports = [ 145 ];
    settings = {
      PasswordAuthentication = true;
      AllowUsers = [ "gelei" ];
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    };
  };

  sops.secrets."moondancer/tailscale" = { };
  tailscale.services.authKeyFile = config.sops.secrets."moondancer/tailscale".path;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}
