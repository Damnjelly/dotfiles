{ pkgs, ... }: 
let
  xwayland = pkgs.writeShellScriptBin "xwayland" ''${builtins.readFile ./xwayland.sh}'';
in {
  home.sessionVariables = {
    SCRIPT_XWAYLAND = "${xwayland}/bin/xwayland";
  };
}
