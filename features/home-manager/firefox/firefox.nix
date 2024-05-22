{ pkgs, inputs, config, ... }: {
  config = {
    programs.firefox = with config.lib.stylix.colors; {
      enable = true;
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
        ];

        userChrome = ''
          #TabsToolbar
          {
              visibility: collapse;
          }'';
      };
    };
    home.persistence."/persist/home/${config.home.username}/firefox" = {
      directories = [ ".mozilla/firefox/gelei" ];
      allowOther = true;
    };
  };
}
