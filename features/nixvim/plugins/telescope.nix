{ pkgs, ... }:
{
  home.packages = [
    pkgs.ripgrep
  ];
  programs.nixvim = {
    plugins.telescope = {
      enable = true;
      extensions.fzf-native.enable = true;
      settings.defaults.mappings.i = {
        "<esc>" = {
          __raw = ''
            function(...)
            return require("telescope.actions").close(...)
            end'';
        };
      };
    };
    keymaps = [
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
      {
        action = "<cmd>Telescope buffers<CR>";
        key = "<leader>b";
      }
    ];
  };
}
