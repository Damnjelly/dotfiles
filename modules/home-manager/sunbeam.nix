{ config, lib, pkgs, ... }: 

with lib;

let
  cfg = config.programs.sunbeam;
  jsonFormat = pkgs.formats.json { };
in {
  options = {
    programs.sunbeam = {
      enable = mkEnableOption "sunbeam";

      package = mkOption {
        type = types.package;
        # TODO: change this for the actual unpackaged sunbeam instead of sunbeam-bin at some point
        default = pkgs.sunbeam-bin;
        defaultText = literalExpression "pkgs.sunbeam-bin";
        description = "The Sunbeam package to install";
      };

      settings = mkOption {
        type = jsonFormat.type;
        default = { };
        example = literalExpression ''
          oneliners = [
            {
              title = "Open Sunbeam Docs";
              command = "Sunbeam open https://pomdtr.github.io/sunbeam";
              exit = true;
            }
          ];
          extensions = {
            github = {
              origin = "github.com/pomdtr/sunbeam/extensions/github.sh";
              prefrences = {
                token = "xxxx";
              };
              root = [
                {
                  title = "List Sunbeam Issues";
                  command = "list-issues";
                  params = {
                    repo = "pomdtr/sunbeam";
                  };
                }
              ];
            };
            nixpkgs = {
              origin = "https://raw.githubusercontent.com/pomdtr/sunbeam/main/extensions/nixpkgs.ts";
            };
          }
        '';
      };
    };
  };
  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
    xdg.configFile."sunbeam/sunbeam.json" = mkIf
      (cfg.settings != { }) {
        source = jsonFormat.generate "sunbeam.json" cfg.settings;
    };
  };
}
