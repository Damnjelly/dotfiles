{ ... }: {
  programs.nixvim.plugins.lsp = {
    enable = true;
    servers = {
      nil_ls.enable = true;
      gdscript.enable = true;
      bashls.enable = true;
    };
  };
  programs.nixvim.keymaps = [ ];
}
