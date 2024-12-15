{ lib
, config
, osConfig
, pkgs
, ...
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
            DEFAULT = "https://www.qwant.com/?l=en&q={}&t=web";
            nm = "https://mynixos.com/search?q={}";
            nw = "https://wiki.nixos.org/index.php?search={}";
            np = "https://search.nixos.org/packages?channel=unstable&size=50&sort=relevance&type=packages&query={}";
            w = "https://en.wikipedia.org/wiki/{}";
            osu = "https://osu.ppy.sh/home/search?mode=user&query={}";
            osb = "https://osu.ppy.sh/beatmapsets?q={}";
            osrs = "https://oldschool.runescape.wiki/w/{}";
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
          #greasemonkey = with config.lib.stylix.colors.withHashtag; [
          #  (pkgs.writeText "darkreader.js" # javascript 
          #    ''
          #      // ==UserScript==
          #      // @name          Dark Reader (Unofficial)
          #      // @icon          https://darkreader.org/images/darkreader-icon-256x256.png
          #      // @namespace     DarkReader
          #      // @description	  Inverts the brightness of pages to reduce eye strain
          #      // @version       4.7.15
          #      // @author        https://github.com/darkreader/darkreader#contributors
          #      // @homepageURL   https://darkreader.org/ | https://github.com/darkreader/darkreader
          #      // @run-at        document-end
          #      // @grant         none
          #      // @include       http*
          #      // @require       https://cdn.jsdelivr.net/npm/darkreader/darkreader.min.js
          #      // @noframes
          #      // ==/UserScript==

          #      DarkReader.auto({
          #        darkSchemeBackgroundColor: "${base01}",
          #        darkSchemeTextColor: "${base05}",
          #      	brightness: 100,
          #      	contrast: 100,
          #      	sepia: 0,
          #      });
          #    '')
          #];
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
