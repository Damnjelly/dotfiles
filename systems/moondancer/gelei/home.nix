{ lib, inputs, ... }:
{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    inputs.stylix.homeManagerModules.stylix
    inputs.sops-nix.homeManagerModules.sops

    ./../../global-home.nix
    ./../../../users/gelei.nix

    ./../../../features/home-manager/cli
  ];

  home.stateVersion = lib.mkDefault "24.05";
}
