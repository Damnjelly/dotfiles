{ ... }:
{
  programs.nixvim.plugins.lsp = {
    enable = true;
    servers = {
      nil-ls = {
        enable = true;
        settings = {
          nix.flake.autoArchive = true;
        };
      };
      gdscript.enable = true;
      bashls.enable = true;
      rust-analyzer = {
        enable = true;
        installCargo = true;
        installRustc = true;
      };
      pylyzer.enable = true;
    };
  };
  programs.nixvim.keymaps = [ ];
}
