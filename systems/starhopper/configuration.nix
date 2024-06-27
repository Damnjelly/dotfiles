{ lib, inputs, ... }:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
    inputs.home-manager.nixosModules.home-manager
    inputs.stylix.nixosModules.stylix
    inputs.nixos-wsl.nixosModules.default

    ./joren/config.nix
    ./../global-config.nix
    ./../../features/nixos/system-packages.nix
  ];

  theme = "madotsuki";
  optinpermanence.enable = false;

  wsl = {
    enable = true;
    wslConf.network.hostname = "starhopper";
  };

  environment.sessionVariables = {
    FLAKE = "/etc/nixos/";
  };

  nix.settings = {
    experimental-features = "nix-command flakes";
    auto-optimise-store = true;
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
