{ lib, config, ... }:
{
  programs.qutebrowser = {
    enable = true;
    searchEngines = {
      DEFAULT = "https://www.startpage.com/do/dsearch?q={}&cat=web&language=english";
      nm = "https://mynixos.com/search?q={}";
      nw = "https://wiki.nixos.org/index.php?search={}";
      np = "https://search.nixos.org/packages?channel=unstable&size=50&sort=relevance&type=packages&query={}";
    };
    settings = {
      url.default_page = "https://www.startpage.com";
    };
    greasemonkey = [ ];
  };
  home.persistence = lib.mkIf config.optinpermanence.enable {
    "/persist/home/${config.home.username}/Qutebrowser" = {
      directories = [ ".cache/qutebrowser" ".local/share/qutebrowser" ];
      allowOther = true;
    };
  };
}
