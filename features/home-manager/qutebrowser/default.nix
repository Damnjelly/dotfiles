{ lib, config, pkgs, ... }:
{
  home.packages = with pkgs; [ python312Packages.adblock ];
  programs.qutebrowser = {
    enable = true;
    searchEngines = {
      DEFAULT = "https://www.startpage.com/do/dsearch?q={}&cat=web&language=english";
      nm = "https://mynixos.com/search?q={}";
      nw = "https://wiki.nixos.org/index.php?search={}";
      np = "https://search.nixos.org/packages?channel=unstable&size=50&sort=relevance&type=packages&query={}";
    };
    settings = {
      tabs ={
        show = "multiple";
        position = "right";
        indicator.width = 0;
      };
      colors.webpage.preferred_color_scheme = "dark";
      fileselect = {
        handler = "external";
        single_file.command = [ "foot" "yazi" "--chooser-file" "{}"];
        multiple_files.command = [ "foot" "yazi" "--chooser-file" "{}"];
        folder.command = [ "foot" "yazi" "--chooser-file" "{}"];
      };
    };
    extraConfig = ''
    c.url.start_pages = [ "http://galaxy:7575" ]
    '';
  };
  home.persistence = lib.mkIf config.optinpermanence.enable {
    "/persist/home/${config.home.username}/Qutebrowser" = {
      directories = [ ".cache/qutebrowser" ".local/share/qutebrowser" ];
      allowOther = true;
    };
  };
}
