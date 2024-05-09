{ pkgs, ... }: {
  imports = [
    ./nixvim.nix
    ./alpha.nix
    ./cmp.nix
    ./theme.nix
    ./keymaps.nix
    ./plugins.nix
    ./obsidian.nix
  ];
  home.packages = with pkgs; [ nixfmt obsidian lazygit ];
}
