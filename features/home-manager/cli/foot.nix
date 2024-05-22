{ lib, ... }: {
  stylix.targets.foot.enable = true;
  programs.foot = {
    enable = true;
    settings = {
      main = { font = lib.mkForce "Kirsch3x:size=20"; };
      tweak = { overflowing-glyphs = "yes"; };
    };
  };
}
