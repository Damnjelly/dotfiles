{ config, ... }:
{
  features.email.accounts.joren122gmail = {
    flavor = "gmail.com";
    address = "joren122@gmail.com";
    passwordCommand = "cat ${config.sops.secrets."email/joren122gmail".path}";
    realName = "Joren Bergsma";
    primary = true;

    msmtp.enable = true;
    notmuch.enable = true;
  };
  sops.secrets."email/joren122gmail" = { };
}
