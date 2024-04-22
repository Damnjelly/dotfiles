{ pkgs, ... }: 
let
  xwayland = pkgs.writeShellScriptBin "xwayland" ''${builtins.readFile ./xwayland.sh}'';
in {
  environment.sessionVariables = {
    SCRIPT_XWAYLAND = "${xwayland}/bin/xwayland";
  };
}
