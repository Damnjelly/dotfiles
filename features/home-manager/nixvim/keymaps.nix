{ ... }: {
  programs.nixvim = {
    globals.mapleader = " ";
    keymaps = [
      # barbar
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

      # telescope
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

      # neotree
      {
        key = "<leader>n";
        action = ":Neotree action=focus reveal toggle<CR>";
        options.silent = true;
      }

      # conform
      {
        action = "<cmd>:Format<CR>";
        key = "<leader>ft";
      }

      # gitsigns
      {
        action = "Gitsigns toggle_current_line_blame<CR>";
        key = "<leader>gb";
      }

      # misc
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

