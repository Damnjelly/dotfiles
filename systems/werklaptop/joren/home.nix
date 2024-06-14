{ lib, inputs, ... }:
{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence

    ./../../global-home.nix
    ./../../../users/gelei.nix

    ./../../../features/home-manager/cli
    ./../../../features/home-manager/nixvim
    ./../../../features/home-manager/shell
  ];
  config = {
    theme = "madotsuki";

    home.stateVersion = lib.mkDefault "23.11";
  };
}
