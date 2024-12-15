{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nixfmt-rfc-style
    beautysh
    prettierd
  ];
  programs.nixvim = {
    plugins.conform-nvim = {
      enable = false;
      settings = {
        notify_on_error = true;
        formatters_by_ft = {
          nix = [ "nixfmt" ];
          bash = [ "beautysh" ];
          javascript = [ "prettierd" ];
          gdscript = [ "gdformat" ];
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
