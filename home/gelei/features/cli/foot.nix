{ pkgs, lib, ... }: {
  stylix.targets.foot.enable = true;
  programs.foot = {
    enable = true;
    package = pkgs.foot;
    settings = { 
      main = { 
        font = lib.mkForce "Kirsch2x:size=20";
      }; 
    };
  };
}
