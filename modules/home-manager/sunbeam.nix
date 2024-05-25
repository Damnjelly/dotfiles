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
        default = pkgs.sunbeam;
        defaultText = literalExpression "pkgs.sunbeam";
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
    xdg.configFile."sunbeam/HMInit/sunbeam.json" = mkIf (cfg.settings != { }) {
      executable = true;
      source = jsonFormat.generate "sunbeam.json" cfg.settings;
      onChange = ''
        cp ${config.xdg.configHome}/sunbeam/HMInit/sunbeam.json ${config.xdg.configHome}/sunbeam/sunbeam.json 
        chmod u+w ${config.xdg.configHome}/sunbeam/sunbeam.json
      '';
    };
  };
}
