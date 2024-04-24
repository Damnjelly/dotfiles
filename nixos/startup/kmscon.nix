{ pkgs, ... }: {
  stylix.targets.kmscon.enable = true;
  services.kmscon = {
    enable = true;
    fonts = [{
      name = "Kirsch2x";
      package = pkgs.kirsch;
    }];
  };
}
