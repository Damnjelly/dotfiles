{ pkgs, inputs, ... }:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./alpha.nix
    ./cmp.nix
    ./conform.nix
    ./dap.nix
    ./keymaps.nix
    ./lint.nix
    ./lsp.nix
    ./neotree.nix
    ./nixvim.nix
    ./obsidian.nix
    ./plugins.nix
    ./telescope.nix
    ./theme.nix
    ./treestitter.nix
  ];
  home.packages = with pkgs; [
    nixfmt-rfc-style
    obsidian
    lazygit
    gdb
  ];
}
