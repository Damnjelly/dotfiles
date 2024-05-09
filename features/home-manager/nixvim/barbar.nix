{ ... }: {
  programs.nixvim.plugins.barbar.enable = true;
  programs.nixvim.keymaps = [
    {
      action = "<cmd>BufferPrevious<CR>";
      key = "<leader>h";
    }
    {
      action = "<cmd>BufferNext<CR>";
      key = "<leader>l";
    }
    {
      action = "<cmd>BufferClose<CR>";
      key = "<leader>q";
    }
  ];
}
