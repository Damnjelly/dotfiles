{ ... }:
{
  stylix.targets.i3.enable = true;
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      floating.criteria = [ { class = "[.]*"; } ];
      window.commands = [
        {
          command = "fullscreen enable";
          criteria = {
            class = "[.]*";
          };
        }
      ];
      bars = [ ];
      terminal = "foot";
    };
  };
}
