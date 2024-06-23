{ config, ... }:
{
  accounts.email.accounts.joren122gmail = {
    flavor = "gmail.com";
    address = "joren122@gmail.com";
    passwordCommand = "cat ${config.sops.secrets."email/joren122gmail".path}";
    realName = "Joren Bergsma";
    primary = true;

    notmuch = {
      enable = true;
      neomutt.enable = true;
    };
    msmtp.enable = true;
    neomutt = {
      enable = true;
      mailboxType = "imap";
    };
  };
  sops.secrets."email/joren122gmail" = { };
  programs.neomutt.enable = true;
}
