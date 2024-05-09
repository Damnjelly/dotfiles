{ ... }: {
  programs.nixvim.plugins.conform-nvim = {
    enable = true;
    formattersByFt = {
      nix = [ "nixfmt" ];
      lua = [ "stylua" ];
      bash = [ "beautysh" ];
    };
  };
  programs.nixvim.keymaps = [{
    action = "<cmd>:Format<CR>";
    key = "<leader>ft";
  }];
}
