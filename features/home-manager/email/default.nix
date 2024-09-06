{ lib, config, pkgs, ... }:
{
  options = with lib; {
    emails = mkOption {
      type = types.attrs;
      default = { };
    };
  };
  imports = [
    ./joren122gmail.nix
    ./joren122hotmail.nix
  ];
  config = {
    services.lieer.enable = true;
    programs = {
      lieer.enable = true;
      mbsync.enable = true;
      msmtp.enable = true;
      notmuch = {
        enable = true;
      };

    };
    accounts.email.maildirBasePath = ".local/share/mail";
    home.persistence = lib.mkIf config.optinpermanence.enable {
      "/persist/home/${config.home.username}/email" = {
        directories = [ ".local/share/mail" ];
        allowOther = false;
      };
    };
    accounts.email.accounts = lib.mapAttrs (n: v: v) config.emails;
  };
}
