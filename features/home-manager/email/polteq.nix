{ config, ... }:
{
  emails.polteq = {
    flavor = "outlook.office365.com";
    address = "joren.bergsma@polteq.nl";
    passwordCommand = "cat ${config.sops.secrets."email/joren122gmail".path}";
    realName = "Joren Bergsma";
    primary = false;

    notmuch.enable = true;
    msmtp.enable = true;
  };
  sops.secrets."email/joren122gmail" = { };
}
