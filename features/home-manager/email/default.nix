{lib, config, ...}:{
  imports = [
    ./joren122gmail.nix
  ];
  services.lieer.enable = true;
  programs = {
    lieer.enable = true;
    mbsync.enable = true;
    msmtp.enable = true;
    notmuch = {
      enable = true;
#     hooks = {
#       preNew = "mbsync --all";
#     };
    };
  };
  accounts.email.maildirBasePath = ".local/share/mail";
  home.persistence = lib.mkIf config.optinpermanence.enable {
    "/persist/home/${config.home.username}/mail" = {
      directories = [ ".local/share/mail" ];
    };
  };
}
