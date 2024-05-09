{ pkgs, ... }: {
  imports = [
    ./alpha.nix
    ./barbar.nix
    ./cmp.nix
    ./conform.nix
    ./keymaps.nix
    ./lsp.nix
    ./neotree.nix
    ./nixvim.nix
    ./obsidian.nix
    ./plugins.nix
    ./telescope.nix
    ./theme.nix
    ./treestitter.nix
  ];
  home.packages = with pkgs; [ nixfmt obsidian lazygit ];
}
