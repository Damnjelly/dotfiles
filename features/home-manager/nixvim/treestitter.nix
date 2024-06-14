{ ... }:
{
  programs.nixvim.plugins = {
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
  };
  programs.nixvim.keymaps = [ ];
}
