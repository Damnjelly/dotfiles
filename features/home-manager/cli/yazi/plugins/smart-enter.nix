{
  pkgs,
  lib,
  config,
  ...
}:
{
  programs.yazi = lib.mkIf config.programs.yazi.enable {
    plugins.smart-enter =
      pkgs.writeText "yazi-smart-enter" # lua
        ''
          return {
          	entry = function()
          		local h = cx.active.current.hovered
          		ya.manager_emit(h and h.cha.is_dir and "enter" or "open", { hovered = true })
          	end,
          }
        '';
  };
}
