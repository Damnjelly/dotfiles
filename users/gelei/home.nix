# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ outputs, inputs, lib, config, ... }: {
  imports = [
    inputs.niri.homeModules.niri
    inputs.nixvim.homeManagerModules.nixvim
    inputs.impermanence.nixosModules.home-manager.impermanence
    outputs.homeManagerModules.sunbeam
    ./../global-home.nix
    ./../../features/home-manager/cli
    ./../../features/home-manager/creative
    ./../../features/home-manager/discord/vesktop.nix
    ./../../features/home-manager/firefox/firefox.nix
    ./../../features/home-manager/games
    ./../../features/home-manager/niri
    ./../../features/home-manager/nixvim
    ./../../features/home-manager/shell
    ./../../features/home-manager/sunbeam
    ./../../features/home-manager/work
  ];
  config.theme = "madotsuki";
  home = {
    homeDirectory = lib.mkDefault "/home/gelei";
    username = lib.mkDefault "gelei";
    stateVersion = lib.mkDefault "23.11";
    sessionPath = [ "$HOME/.local/bin" ];
  };

  programs.git = {
    userName = "Damnjelly";
    userEmail = "joren122@hotmail.com";
  };
}
