{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    git
    nh
    sops
  ];
  fonts.packages = with pkgs; [
    kirsch
    cozette
  ];
}
