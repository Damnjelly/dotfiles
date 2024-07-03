{
  pkgs,
  lib,
  inputs,
  config,
  ...
}:
{
  config = {
    programs.firefox = with config.lib.stylix.colors; {
      enable = true;
      profiles.${config.home.username} = {
        search = {
          default = "Startpage";
          order = [
            "Startpage"
            "Google"
          ];
          engines = {
            "Bing".metaData.hidden = true;
            "Google".metaData.hidden = true;
            "DuckDuckGo".metaData.hidden = true;
            "Qwant".metaData.hidden = true;
            "eBay".metaData.hidden = true;

            "Wikipedia (en)".metaData.alias = "@w";

            "myNixos" = {
              urls = [
                {
                  template = "https://mynixos.com/search?";
                  params = [
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@nm" ];
            };

            "GitHub" = {
              urls = [
                {
                  template = "https://github.com/search";
                  params = [
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "${pkgs.fetchurl {
                url = "https://github.githubassets.com/favicons/favicon.svg";
                sha256 = "sha256-apV3zU9/prdb3hAlr4W5ROndE4g3O1XMum6fgKwurmA=";
              }}";
              definedAliases = [ "@gh" ];
            };

            "Nix Packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "channel";
                      value = "unstable";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@np" ];
            };

            "NixOS Wiki" = {
              urls = [
                {
                  template = "https://wiki.nixos.org/index.php";
                  params = [
                    {
                      name = "search";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@nw" ];
            };

            "Nixpkgs Issues" = {
              urls = [
                {
                  template = "https://github.com/NixOS/nixpkgs/issues";
                  params = [
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@ni" ];
            };

            "Youtube" = {
              urls = [
                {
                  template = "https://www.youtube.com/results";
                  params = [
                    {
                      name = "search_query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "${pkgs.fetchurl {
                url = "www.youtube.com/s/desktop/8498231a/img/favicon_144x144.png";
                sha256 = "sha256-lQ5gbLyoWCH7cgoYcy+WlFDjHGbxwB8Xz0G7AZnr9vI=";
              }}";
              definedAliases = [ "@y" ];
            };

          };
          force = true;
        };

        settings = {
          "browser.startup.homepage" = "https://www.startpage.com/";
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "layers.acceleration.force-enabled" = true;
          "gfx.webrender.all" = true;
          "gfx.webrender.enabled" = true;
          "layout.css.backdrop-filter.enabled" = true;
          "svg.context-properties.content.enabled" = true;
          "browser.fullscreen.autohid" = false;
          "uc.tweak.popup-search" = true;
        };

        # Extensions can be found at: https://gitlab.com/rycee/nur-expressions/-/blob/master/pkgs/firefox-addons/generated-firefox-addons.nix
        extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
          bitwarden
          stylus
          sidebery
          ublock-origin
          vimium
          startpage-private-search
        ];

        userChrome = ''
          #TabsToolbar
          {
              visibility: collapse;
          }'';
      };
    };
    home.persistence = lib.mkIf config.optinpermanence.enable {
      "/persist/home/${config.home.username}/firefox" = {
        directories = [ ".mozilla/firefox/gelei" ];
        allowOther = true;
      };
    };
  };
}
