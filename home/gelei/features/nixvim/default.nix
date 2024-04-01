{pkgs, ...}: {
  imports = [
    ./nixvim.nix
  ];
  home.packages = with pkgs; [
    alejandra
  ];
}
