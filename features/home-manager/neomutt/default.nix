{ config, lib, ... }:
with lib;
{
  imports = [
    ./mutt
    ./glow
  ];
  config.accounts.email.accounts = mapAttrs (
    n: _:
    recursiveUpdate { } {
      neomutt = {
        enable = true;
        mailboxType =
          if
            config.emails.${n}.flavor == [
              "gmail.com"
              "outlook.office365.com"
            ]
          then
            "imap"
          else
            "maildir";
      };
      notmuch.neomutt.enable = true;
    }
  ) config.emails;
}
