{ pkgs, ... }: {
  stylix.targets.kmscon.enable = false;
  services.kmscon = {
    enable = true;
    fonts = [{
      name = "Kirsch2x";
      package = pkgs.kirsch;
    }];
  };
}
