{ ... }: {
  programs.nixvim.plugins.conform_nvim = {
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
