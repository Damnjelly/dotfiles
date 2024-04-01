{...}: {
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

      alpha = {
        enable = true;
        layout = [
          {
            type = "padding";
            val = 8;
          }
          {
            opts = {
              hl = "Type";
              position = "center";
            };
            type = "text";
            val = [
              "███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗"
              "████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║"
              "██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║"
              "██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║"
              "██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║"
              "╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝"
            ];
          }
          {
            type = "padding";
            val = 10;
          }
          {
            opts = {
              hl = "Keyword";
              position = "center";
            };
            type = "text";
            val = "TODO: Fix my life";
          }
        ];
      };

      neo-tree = {
        enable = true; # TODO: configure
        closeIfLastWindow = true;
        window = {
          width = 30;
          autoExpandWidth = true;
        };
      };

      nvim-colorizer.enable = true;

      yanky.enable = true; # TODO: configure

      lualine.enable = true; # TODO: configure

      telescope = {
        enable = true;
        extensions.fzf-native.enable = true;
      };

      twilight.enable = false;

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
        smartRename = {
          enable = true;
        };
        navigation = {
          enable = true;
        };
      };
      which-key.enable = true;

      lspkind.enable = true;

      navic.enable = true;

      trouble.enable = true;

      lsp-lines = {
        enable = false;
        currentLine = true;
      };

      spider.enable = true;

      neoscroll.enable = true; # TODO: configure

      nix.enable = true;

      conform-nvim = {
        enable = true;
        formattersByFt = {
          nix = ["alejandra"];
          lua = ["stylua"];
          bash = ["beautysh"];
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
      luasnip.enable = true;
      cmp = {
        enable = true;
        settings = {
          sources = [
            {
              name = "treesitter";
            }
            {
              name = "buffer";
            }
            {
              name = "nvim_lsp";
            }
            {
              name = "path";
            }
            {
              name = "yanky";
            }
            {
              name = "luasnip";
            }
          ];
          snippet.expand = ''
            function(args)
              require('luasnip').lsp_expand(args.body)
            end
          '';
          mapping = {
            "<CR>" = "cmp.mapping.confirm({select = true })";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-Space>" = "cmp.mapping.complete()";
            "<Tab>" = ''
              cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
                -- they way you will only jump inside the snippet region
                elseif luasnip.expand_or_locally_jumpable() then
                  luasnip.expand_or_jump()
                elseif has_words_before() then
                  cmp.complete()
                else
                  fallback()
                end
              end, { "i", "s" })
            '';
            "<S-Tab>" = ''
              cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                  luasnip.jump(-1)
                else
                  fallback()
                end
              end, { "i", "s" })
            '';
            "<Down>" = "cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), {'i'})";
            "<Up>" = "cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), {'i'})";
          };
          window.completion.border = "shadow";
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
        action = "<cmd>Telescope find_files<CR>";
        key = "<leader>ff";
      }
      {
        action = "<cmd>Telescope git_files<CR>";
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
