{ ... }: {
  programs.nixvim.plugins.telescope = {
    enable = true;
    extensions.fzf-native.enable = true;
  };
  programs.nixvim.keymaps = [
    {
      action = "<cmd>Telescope find_files<CR>";
      key = "<leader>ff";
    }
    {
      action = "<cmd>Telescope live_grep<CR>";
      key = "<leader>fl";
    }
    {
      action = "<cmd>Telescope grep_string<CR>";
      key = "<leader>fg";
    }
  ];
}
