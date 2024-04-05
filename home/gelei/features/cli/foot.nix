{pkgs, lib, ...}: {
  stylix.targets.foot.enable = true;
  programs.foot = {
    enable = true;
    package = pkgs.foot;
    settings = {
      main = {
        font = lib.mkForce "kirsch3x:size=22";
      };
    };
  };
}
