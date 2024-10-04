{
  lib,
  config,
  osConfig,
  pkgs,
  ...
}:
{
  config =
    lib.mkIf (builtins.elem config.home.username osConfig.features.desktopManagers.niri.enableFor)
      {
        home.packages = with pkgs; [
          python312Packages.adblock
          keyutils
        ];
        xdg.mimeApps = {
          enable = true;
          defaultApplications = {
            "text/html" = [ "org.qutebrowser.qutebrowser.desktop" ];
          };
        };
        programs.qutebrowser = {
          enable = true;
          package = pkgs.qutebrowser.override { enableWideVine = true; };
          searchEngines = {
            DEFAULT = "https://www.startpage.com/do/dsearch?q={}&cat=web&language=english";
            nm = "https://mynixos.com/search?q={}";
            nw = "https://wiki.nixos.org/index.php?search={}";
            np = "https://search.nixos.org/packages?channel=unstable&size=50&sort=relevance&type=packages&query={}";
          };
          keyBindings = {
            normal = {
              "pa" = "spawn --userscript qute-bitwarden";
              "pu" = "spawn --userscript qute-bitwarden -e";
              "pw" = "spawn --userscript qute-bitwarden -w";
              "pt" = "spawn --userscript qute-bitwarden -T";
            };
          };
          settings = {
            tabs = {
              show = "multiple";
              position = "top";
              indicator.width = 0;
            };
            colors.webpage.preferred_color_scheme = "dark";
            fileselect = {
              handler = "external";
              single_file.command = [
                "foot"
                "yazi"
                "--chooser-file"
                "{}"
              ];
              multiple_files.command = [
                "foot"
                "yazi"
                "--chooser-file"
                "{}"
              ];
              folder.command = [
                "foot"
                "yazi"
                "--chooser-file"
                "{}"
              ];
            };
            content = {
              blocking.enabled = true;
              javascript.clipboard = "access-paste";
            };
          };
          extraConfig = # python
          ''
            c.tabs.padding = {"bottom": 4, "left": 4, "right": 4, "top": 4}
          '';
        };
        home.persistence = lib.mkIf osConfig.optinpermanence.enable {
          "/persist/home/${config.home.username}/qutebrowser" = {
            directories = [
              ".cache/qutebrowser"
              ".local/share/qutebrowser"
            ];
            allowOther = true;
          };
        };
      };
}
