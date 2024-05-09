{ ... }: {
  programs.nixvim.plugins = {
    autoclose.enable = true;
    barbecue.enable = true;
    gitsigns.enable = true;
    noice.enable = true;
    nvim-colorizer.enable = true;
    lualine.enable = true;
    which-key.enable = true;
    trouble.enable = true;
    spider.enable = true;
    surround.enable = true;
    nix.enable = true;
  };
}
