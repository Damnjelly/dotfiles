{ ... }: {
  programs.nixvim.plugins.neo-tree = {
    enable = true;
    closeIfLastWindow = true;
    window = {
      width = 30;
      autoExpandWidth = true;
    };
  };
  programs.nixvim.keymaps = [{
    key = "<leader>n";
    action = ":Neotree action=focus reveal toggle<CR>";
    options.silent = true;
  }];
}
