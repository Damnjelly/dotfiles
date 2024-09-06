{
  config,
  inputs,
  ...
}:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
    inputs.disko.nixosModules.default
    inputs.home-manager.nixosModules.home-manager
    inputs.stylix.nixosModules.stylix

    ./hardware-configuration.nix
    ./gelei/config.nix
    ./../global-config.nix

    ./../../features/nixos/greetd.nix
    ./../../features/nixos/shares.nix
    #./../../features/nixos/kanata.nix
    ./../../features/nixos/ssh.nix
    ./../../features/nixos/openrgb.nix
    ./../../features/nixos/stylix.nix
    ./../../features/nixos/system-packages.nix
    ./../../features/nixos/tailscale.nix
  ];

  # system name
  networking.hostName = "nightglider";

  theme = "madotsuki";
  optinpermanence.enable = true;

  services.tailscale.authKeyFile = config.sops.secrets."nightglider/tailscale".path;
 
  programs.fuse.userAllowOther = true;

  fileSystems."/persist".neededForBoot = true;
  environment.persistence."/persist/system" = {
    hideMounts = true;
    directories = [
      "/etc/nixos/"
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/var/lib/alsa"
      "/etc/NetworkManager/system-connections"
      "/var/lib/tailscale"

    ];
    files = [ "/etc/machine-id" ];
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
