{ pkgs, ... }:
{
  home.packages = with pkgs; [
    statix
    python312Packages.demjson3
  ];
  programs.nixvim.plugins.lint = {
    enable = true;
    lintersByFt = {
      nix = [ "statix" ];
      json = [ "jsonlint" ];
    };
  };
}
