{ osConfig, ... }:
{
  programs.nixvim.plugins.alpha = {
    enable = true;
    layout = [
      {
        type = "padding";
        val = 4;
      }
      {
        opts = {
          position = "center";
          hl = "type";
        };
        type = "text";
        val = osConfig.theme.alpha;
      }
      {
        type = "padding";
        val = 2;
      }
      {
        type = "group";
        val =
          let
            mkButton = shortcut: cmd: val: hl: {
              type = "button";
              inherit val;
              opts = {
                inherit hl shortcut;
                keymap = [
                  "n"
                  shortcut
                  cmd
                  { }
                ];
                position = "center";
                cursor = 0;
                width = 40;
                align_shortcut = "right";
                hl_shortcut = "Keyword";
              };
            };
          in
          [
            (mkButton "f" "<CMD>lua require('telescope.builtin').find_files()<CR>" "🔍 Find File" "Operator")
          ];
      }
      {
        type = "padding";
        val = 2;
      }
      {
        opts = {
          position = "center";
          hl = "Keyword";
        };
        type = "text";
        val = "TODO: Fix my life";
      }
    ];
  };
}
