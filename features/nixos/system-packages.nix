{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    git
    nh
    sops
  ];
}
