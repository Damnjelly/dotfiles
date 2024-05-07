{ pkgs, ... }: {
  imports = [
    ./nixvim.nix
    ./alpha.nix
    ./cmp.nix
    ./theme.nix
    ./keymaps.nix
    ./plugins.nix
  ];
  home.packages = with pkgs; [ nixfmt obsidian lazygit ];
}
