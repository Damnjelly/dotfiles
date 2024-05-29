{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    git
    nh
    # libsForQt5.kdeconnect-kde
  ];
  fonts.packages = with pkgs; [ kirsch cozette ];
}
