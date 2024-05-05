{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ git nh ];
  fonts.packages = with pkgs; [ kirsch cozette unifont ];
}
