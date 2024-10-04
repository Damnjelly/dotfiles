{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nixfmt-rfc-style
    beautysh
    prettierd
  ];
  programs.nixvim = {
    plugins.conform-nvim = {
      enable = true;
      settings = {
        notify_on_error = true;
        formatters_by_ft = {
          nix = [ "nixfmt" ];
          bash = [ "beautysh" ];
          javascript = [ "prettierd" ];
        };
      };
    };
    keymaps = [
      {
        action = "<cmd>:Format<CR>";
        key = "<leader>ft";
      }
    ];
  };
}
