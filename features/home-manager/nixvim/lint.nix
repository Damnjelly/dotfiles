{ pkgs, ... }: {
  home.packages = [ pkgs.statix ];
  programs.nixvim.plugins.lint = {
    enable = true;
    lintersByFt = {
      nix = ["statix"];
      python = ["flake8"];
      json = ["jsonlint"];
      java = ["checkstyle"];
    };
  };
}
