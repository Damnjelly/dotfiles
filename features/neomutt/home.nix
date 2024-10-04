{ config, lib, ... }:
let
  cfg = config.features.neomutt;
in
{
  imports = [
    ./mutt
    ./glow
  ];

  options.features.neomutt.enable = lib.mkEnableOption "neomutt";

  config =
    with lib;
    lib.mkIf cfg.enable {
      programs.neomutt.enable = true;
      accounts.email.accounts = mapAttrs (
        n: _:
        recursiveUpdate { } {
          neomutt = {
            enable = true;
            mailboxType = "imap";
            #           if
            #             config.emails.${n}.flavor == [
            #               "gmail.com"
            #               "outlook.office365.com"
            #             ]
            #           then
            #             "imap"
            #           else
            #             "maildir";
          };
          notmuch.neomutt.enable = true;
        }
      ) config.features.email.accounts;

      xdg.desktopEntries.neomutt = lib.mkIf cfg.enable {
        name = "Neomutt";
        genericName = "Mail client";
        exec = "neomutt";
        terminal = true;
      };
    };
}
