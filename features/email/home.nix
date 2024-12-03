{
  lib,
  config,
  osConfig,
  ...
}:
{
  options = with lib; {
    features.email = {
      enable = lib.mkEnableOption "email";
      accounts = mkOption {
        type = types.attrs;
        default = { };
      };
    };
  };

  imports = [
    ./accounts/joren122gmail.nix
    ./accounts/joren122hotmail.nix
  ];

  config = lib.mkIf config.features.email.enable {
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
    home.persistence = lib.mkIf osConfig.optinpermanence.enable {
      "/persist/home/${config.home.username}/email" = {
        directories = [ ".local/share/mail" ];
        allowOther = false;
      };
    };
    accounts.email.accounts = lib.mapAttrs (n: v: v) config.features.email.accounts;
  };
}
