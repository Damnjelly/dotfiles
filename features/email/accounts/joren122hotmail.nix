{ config, ... }:
{
  features.email.accounts.joren122hotmail = {
    flavor = "outlook.office365.com";
    address = "joren122@hotmail.com";
    passwordCommand = "cat ${config.sops.secrets."email/joren122hotmail".path}";
    realName = "Joren Bergsma";
    primary = false;

    msmtp.enable = true;
    notmuch.enable = true;
  };
  sops.secrets."email/joren122hotmail" = { };
}
