{ pkgs, ... }:
let
  volumemixer = pkgs.writeShellScriptBin "volumemixer" ''${builtins.readFile ./volumemixer.sh}'';
  applauncher = pkgs.writeShellScriptBin "applauncher" ''${builtins.readFile ./applauncher.sh}'';
in {
  programs.sunbeam = {
    enable = true;
    settings = {
      oneliners = [
        {
          title = "Open Sunbeam Docs";
          command = "Sunbeam open https://pomdtr.github.io/sunbeam";
          exit = true;
        }
      ];
      extensions = {
        nixpkgs = {
          origin = "https://raw.githubusercontent.com/pomdtr/sunbeam/main/extensions/nixpkgs.ts";
        };
        volumemixer = {
          origin = "${volumemixer}/bin/volumemixer";
        };
        applauncher = {
          origin = "${applauncher}/bin/applauncher";
        };
      };
    };
  };
}
