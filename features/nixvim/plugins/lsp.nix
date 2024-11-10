{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.lsp = {
      enable = true;
      servers = {
        nixd = {
          enable = true;
        };
        bashls.enable = true;
        rust_analyzer = {
          enable = true;
          installCargo = true;
          installRustc = true;
        };
        pylyzer.enable = true;
        typos_lsp.enable = true;
        ts_ls.enable = true;
        gdscript = {
          enable = true;
          package = pkgs.gdtoolkit_4;
        };
      };
    };
  };
}
