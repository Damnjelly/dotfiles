{
  programs.nixvim = {
    globals.mapleader = " ";
    keymaps = [
      {
        action = "ggVG$";
        mode = "n";
        key = "<C-a>";
      }
      {
        action = "<cmd>Gitsigns toggle_current_line_blame<CR>";
        key = "<leader>gb";
      }
      {
        action = ":m '>+1<CR>gv=gv";
        mode = "v";
        key = "J";
      }
      {
        action = ":m '<-2<CR>gv=gv";
        mode = "v";
        key = "K";
      }
      {
        action = "<C-d>zz";
        mode = "n";
        key = "<C-d>";
      }
      {
        action = "<C-u>zz";
        mode = "n";
        key = "<C-u>";
      }
      {
        action = "nzzzv";
        mode = "n";
        key = "n";
      }
      {
        action = "Nzzzv";
        mode = "n";
        key = "N";
      }
      {
        action = ''"_dp'';
        key = "<leader>p";
      }
      {
        action = ''"_dP'';
        key = "<leader>P";
      }
      {
        action = ''"+y'';
        mode = "n";
        key = "<leader>y";
      }
      {
        action = ''"+Y'';
        mode = "n";
        key = "<leader>Y";
      }
      {
        action = ''"+y'';
        mode = "v";
        key = "<leader>y";
      }
      {
        action = ''"+d'';
        mode = "n";
        key = "<leader>d";
      }
      {
        action = ''"+d'';
        mode = "v";
        key = "<leader>d";
      }
      {
        action = "[[:%s/<<C-r><C-w>>/<C-r><C-w>/gI<Left><Left><Left>]]";
        mode = "n";
        key = "<leader>s";
      }
    ];
  };
}
