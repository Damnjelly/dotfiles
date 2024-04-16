{ pkgs, ... }: {
  imports = [ ./nixvim.nix ./alpha.nix ./cmp.nix ];
  home.packages = with pkgs; [ nixfmt ];
}
