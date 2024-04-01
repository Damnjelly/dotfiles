{config, ...}: let
  yuck = builtins.readFile ./ewwconfig/eww.yuck;
  scss = builtins.readFile ./ewwconfig/eww.scss;
in {
  config = with config.lib.stylix.colors; {
    home.file."/.config/eww/eww.yuck".text = "${yuck}";
    home.file."/.config/eww/eww.scss".text = ''
        $base01: #${base01};
        $base02: #${base02};
        $base03: #${base03};
        $base04: #${base04};
        $base05: #${base05};
        $base06: #${base06};
        $base07: #${base07};
        $base08: #${base08};
        $base09: #${base09};
        $base0A: #${base0A};
        $base0B: #${base0B};
        $base0C: #${base0C};
        $base0D: #${base0D};
        $base0E: #${base0E};
        $base0F: #${base0F};
      ${scss}
    '';

    #programs.eww = {
    #  enable = true;
    #	package = pkgs.eww;
    #};
  };
}
