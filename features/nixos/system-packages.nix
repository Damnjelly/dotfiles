{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    git
    nh
    comma
    sops
  ];
}
