{ lib, ... }: {
  stylix.targets.foot.enable = true;
  programs.foot = {
    enable = true;
    settings = { main = { font = lib.mkForce "Kirsch2x:size=20"; }; };
  };
}
