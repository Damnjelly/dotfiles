{ pkgs, inputs, config, ... }:
let userChrome = builtins.readFile ./firefox-userChrome.css;
in {
  config = {
    programs.firefox = with config.lib.stylix.colors; {
      enable = true;
      package = pkgs.firefox;
      profiles.gelei = {
        search.engines = {
          "Nix Packages" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                {
                  name = "type";
                  value = "packages";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }];

            icon =
              "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };
        };
        search.force = true;

        bookmarks = [
          {
            name = "MyNixOS";
            url = "https://mynixos.com/";
          }
          {
            name = "NixOS Search";
            url = "https://search.nixos.org/packages";
          }
          {
            name = "Photopea";
            url = "https://www.photopea.com/";
          }
        ];

        settings = {
          "browser.search.widget.inNavBar" = false;
          "services.sync.prefs.sync.browser.urlbar.showSearchSuggestionsFirst" =
            false;
          "browser.toolbars.bookmarks.visibility" = "never";
        };

        # Extensions can be found at: https://gitlab.com/rycee/nur-expressions/-/blob/master/pkgs/firefox-addons/generated-firefox-addons.nix
        extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
          bitwarden
          stylus
        ];

        userChrome = ''
          #fullscr-toggler { background-color: rgba(0, 0, 0, 0) !important; }
          :root {
            --uc-bg-color: #${base00};
            --uc-show-new-tab-button: none;
            --uc-show-tab-separators: none;
            --uc-tab-separators-color: none;
            --uc-tab-separators-width: none;
            --uc-tab-fg-color: #${base05};
            --autocomplete-popup-background: var(--mff-bg) !important;
            --default-arrowpanel-background: var(--mff-bg) !important;
            --default-arrowpanel-color: #${base0F} !important;
            --lwt-toolbarbutton-icon-fill: var(--mff-icon-color) !important;
            --panel-disabled-color: #f9f9fa80;
            --toolbar-bgcolor: var(--mff-bg) !important;
            --urlbar-separator-color: transparent !important;
            --mff-bg: #${base00};
            --mff-icon-color: #${base05};
            --mff-nav-toolbar-padding: 8px;
            --mff-sidebar-bg: var(--mff-bg);
            --mff-sidebar-color: #${base06};
            --mff-tab-border-radius: 0px;
            --mff-tab-color: #${base08};
            --mff-tab-font-family: "FiraCode Nerd Font";
            --mff-tab-font-size: 11pt;
            --mff-tab-font-weight: 400;
            --mff-tab-height: 32px;
            --mff-tab-pinned-bg: #${base05};
            --mff-tab-selected-bg: #${base03};
            --mff-tab-soundplaying-bg: #${base0E};
            --mff-urlbar-color: #${base0D};
            --mff-urlbar-focused-color: #${base03};
            --mff-urlbar-font-family: "Fira Code";
            --mff-urlbar-font-size: 11pt;
            --mff-urlbar-font-weight: 700;
            --mff-urlbar-results-color: #${base06};
            --mff-urlbar-results-font-family: "Fira Code";
            --mff-urlbar-results-font-size: 11pt;
            --mff-urlbar-results-font-weight: 700;
            --mff-urlbar-results-url-color: #${base0D};
          }

          #back-button > .toolbarbutton-icon{
            --backbutton-background: transparent !important;
            border: none !important;
          }

          #back-button {
            list-style-image: url("file:///home/gelei/Documents/nix-config/home/features/firefox/left-arrow.svg") !important;
          }

          #forward-button {
            list-style-image: url("file:///home/gelei/Documents/nix-config/home/features/firefox/right-arrow.svg") !important;
          }

          /* Options with pixel amounts could need to be adjusted, as this only works for my laptop's display */
          #titlebar {
            -moz-box-ordinal-group: 0 !important;
          } 

          .tabbrowser-tab:not([fadein]),
          #tracking-protection-icon-container, 
          #identity-box {
            display: none !important;
            border: none !important;
          }
          #urlbar-background, .titlebar-buttonbox-container, #nav-bar, .tabbrowser-tab:not([selected]) .tab-background{
              background: var(--uc-bg-color) !important;
            border: none !important;
          }
          #urlbar[breakout][breakout-extend] {
              top: calc((var(--urlbar-toolbar-height) - var(--urlbar-height)) / 2) !important;
              left: 0 !important;
              width: 100% !important;
          }

          #urlbar[breakout][breakout-extend] > #urlbar-input-container {
              height: var(--urlbar-height) !important;
              padding-block: 0 !important;
              padding-inline: 0 !important;
          }

          #urlbar[breakout][breakout-extend] > #urlbar-background {
              animation-name: none !important;
              box-shadow: none !important;
          }
          #urlbar-background {
            box-shadow: none !important;
          }
          /*#tabs-newtab-button {
            display: var(--uc-show-new-tab-button) !important;
          }*/
          .tabbrowser-tab::after {
            border-left: var(--uc-tab-separators-width) solid var(--uc-tab-separators-color) !important;
            display: var(--uc-show-tab-separators) !important;
          }
          .tabbrowser-tab[first-visible-tab][last-visible-tab]{
            background-color: var(--uc-bar-bg-color) !important;
          }
          .tab-close-button.close-icon {
            display: none !important;
          }
          .tabbrowser-tab:hover .tab-close-button.close-icon {
            display: block !important;
          }
          #urlbar-input {
            text-align: center !important;
          }
          #urlbar-input:focus {
            text-align: left !important;
          }
          #urlbar-container {
            margin-left: 3vw !important;
          }
          .tab-text.tab-label {
            color: var(--uc-tab-fg-color) !important;
          }
          #navigator-toolbox {
            border-bottom: 0px solid ${base08} !important;
            background: var(--uc-bg-color) !important;
          }

          .urlbar-icon > image {
            fill: var(--mff-icon-color) !important;
            color: var(--mff-icon-color) !important;
          }

          .toolbarbutton-text {
            color: var(--mff-icon-color)  !important;
          }
          .urlbar-icon {
            color: var(--mff-icon-color)  !important;

          }
        '';
      };
    };
  };
}
