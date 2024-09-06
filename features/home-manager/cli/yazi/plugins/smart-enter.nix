{ lib, config, ... }:
{
  xdg = lib.mkIf config.programs.yazi.enable {
    configFile."yazi/plugins/smart-enter.yazi/init.lua".text = # lua
      ''
        return {
        	entry = function()
        		local h = cx.active.current.hovered
        		ya.manager_emit(h and h.cha.is_dir and "enter" or "open", { hovered = true })
        	end,
        }
      '';
  };
  programs.yazi.keymap = lib.mkIf config.programs.yazi.enable {
    manager = {
      prepend_keymap = [
        {
          run = "plugin --sync smart-enter";
          on = [ "<Enter>" ];
          desc = "Enter the child directory, or open the file";
        }
      ];
    };
  };
}
