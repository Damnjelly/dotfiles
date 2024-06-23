{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    git
    nh
    sops
    spotify
  ];
  fonts.packages = with pkgs; [
    kirsch
    cozette
  ];
}
