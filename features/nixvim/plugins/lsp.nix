{
  programs.nixvim = {
    plugins.lsp = {
      enable = true;
      servers = {
        nixd = {
          enable = true;
        };
        gdscript.enable = true;
        bashls.enable = true;
        rust-analyzer = {
          enable = true;
          installCargo = true;
          installRustc = true;
        };
        pylyzer.enable = true;
        typos-lsp.enable = true;
        ts-ls.enable = true;
      };
    };
  };
}
