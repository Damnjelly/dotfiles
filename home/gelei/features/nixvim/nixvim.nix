{ ... }: {
  stylix.targets.nixvim.enable = true;
  programs.nixvim = {
    enable = true;
    globals.mapleader = ",";

    colorschemes.kanagawa.enable = true;

    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      tabstop = 2;
    };

    plugins = {
      autoclose.enable = true; # TODO: configure
      barbar.enable = true; # TODO: configure
      barbecue.enable = true;
      neo-tree = {
        enable = true; # TODO: configure
        closeIfLastWindow = true;
        window = {
          width = 30;
          autoExpandWidth = true;
        };
      };
      nvim-colorizer.enable = true;
      lualine.enable = true; # TODO: configure
      telescope = {
        enable = true;
        extensions.fzf-native.enable = true;
      };
      which-key.enable = true;
      trouble.enable = true;
      spider.enable = true;
      surround.enable = true;
      nix.enable = true;
      treesitter = {
        enable = true;
        indent = true;
        nixvimInjections = true;
      };
      treesitter-refactor = {
        enable = true;
        highlightDefinitions = {
          enable = true;
          clearOnCursorMove = true;
        };
        smartRename = { enable = true; };
        navigation = { enable = true; };
      };
      conform-nvim = {
        enable = true;
        formattersByFt = {
          nix = [ "nixfmt" ];
          lua = [ "stylua" ];
          bash = [ "beautysh" ];
        };
      };
      lsp = {
        enable = true;
        servers = {
          nil_ls.enable = true;
          gdscript.enable = true;
          bashls.enable = true;
        };
      };
    };
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
    extraConfigLuaPre = ''
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end
      local luasnip = require("luasnip")
    '';
    extraConfigLua = ''
      vim.api.nvim_create_user_command("Format", function(args)
        local range = nil
        if args.count ~= -1 then
          local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
          range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, end_line:len() },
          }
        end
        require("conform").format({ async = true, lsp_fallback = true, range = range })
      end, { range = true })
    '';
  };
}
