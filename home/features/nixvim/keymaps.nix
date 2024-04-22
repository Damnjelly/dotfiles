{ ... }: {
  programs.nixvim = {
    globals.mapleader = ",";
    keymaps = [
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
      {
        action = "<cmd>Telescope find_files<CR>";
        key = "<leader>ff";
      }
      {
        action = "<cmd>Telescope grep_string<CR>";
        key = "<leader>gf";
      }
      {
        key = "<leader>n";
        action = ":Neotree action=focus reveal toggle<CR>";
        options.silent = true;
      }
      {
        action = "<mcd>conform.format()<CR>";
        key = "<leader>ft";
      }
      {
        action = ''"+p'';
        key = "<leader>p";
      }
      {
        action = ''"+y'';
        key = "<leader>y";
      }
    ];
  };
}

