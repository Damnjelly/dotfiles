{ ... }: {
  programs.nixvim.plugins = {
    autoclose.enable = true; # TODO: configure
    barbar.enable = true; # TODO: configure
    barbecue.enable = true;
    gitsigns.enable = true;
    neo-tree = {
      enable = true; # TODO: configure
      closeIfLastWindow = true;
      window = {
        width = 30;
        autoExpandWidth = true;
      };
    };
    obsidian = {
      enable = true;
      dir = "~/Documents/obsidian";
    };
    noice.enable = true;
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
}
