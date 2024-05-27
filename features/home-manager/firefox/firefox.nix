{ pkgs, lib, inputs, config, ... }: {
  config = {
    programs.firefox = with config.lib.stylix.colors; {
      enable = true;
      profiles.gelei = {
        search.engines = {
          "myNixos" = {
            urls = [{
              template = "https://mynixos.com/";
              params = [
                {
                  name = "type";
                  value = "options";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }];
            icon =
              "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@mn" ];
          };
        };
        search.force = true;

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
