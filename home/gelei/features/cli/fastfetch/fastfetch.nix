{ pkgs, ... }:
let config = builtins.readFile ./fastfetch-config.jsonc;
in {
  home.packages = [ pkgs.fastfetch ];
  xdg.configFile."fastfetch/config.jsonc".text = "${config}";
}
