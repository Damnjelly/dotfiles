{
  config,
  osConfig,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.features.neomutt.enable {
    home.packages = with pkgs; [
      html2text
      lynx
      urlscan
    ];

    programs.neomutt = {
      extraConfig = # muttrc
        ''
          set mailcap_path = $HOME/.config/neomutt/mailcap

                    #### General Key Bindings
                    source $HOME/.config/neomutt/keys/unbinds.muttrc 
                    source $HOME/.config/neomutt/keys/binds.muttrc 

                    #### General Settings
                    set smtp_authenticators = 'gssapi:login'
                    unset help
                    set sleep_time = 0            # Pause 0 seconds for informational messages
                    set pager_read_delay = 3      # View a message for 3 seconds to mark as read
                    set mark_old = no              # Unread mail stay unread until read
                    set mime_forward = no          # attachments are forwarded with mail
                    set wait_key = no              # mutt won't ask "press key to continue"
                    set fast_reply                # skip to compose when replying
                    set fcc_attach                # save attachments with the body
                    set forward_format = "FW: %s" # format of subject when forwarding
                    set forward_quote              # quote forwarded message
                    set reverse_name              # reply as whomever it was to
                    set reverse_realname=yes      # use any real name provided when replying
                    set auto_tag                  # automatically apply commands to all tagged messages (if some messages are tagged)
                    set include                    # include message in replies
                    set mail_check=5              # to avoid lags using IMAP with some email providers (yahoo for example)
                    set timeout=5                 # how long to wait after user input until unblocking background stuff like mail syncing
                    set count_alternatives=yes    # recurse into text/multipart when looking for attachment types
                    set thorough_search=no        # don't process mail (via mailcap etc) before parsing with queries like ~B 
                    set flag_safe                 # flagged messages can't be deleted

                    #### Colors, Symbols and Formatting
                    source ~/.config/neomutt/styles.muttrc

                    #### Header Options
                    ignore *                                # ignore all headers
                    unignore to: cc:                        # ..then selectively show only these headers
                    unhdr_order *                           # some distros order things by default
                    hdr_order from: to: cc: date: subject:  # header item ordering

                    #### View Settings
                    set allow_ansi             # allow ansi escape codes (e.g. colors)
                    set pager_index_lines = 10 # number of index lines to show
                    set pager_context = 3      # number of context lines to show
                    set pager_stop             # don't go to next message automatically
                    set menu_scroll            # scroll in menus
                    set smart_wrap             # wrap lines at word boundaries rather than splitting up words
                    set wrap=90                # email view width
                    set quote_regexp = "^( {0,4}[>|:#%]| {0,4}[a-z0-9]+[>|]+)+"
                    set reply_regexp = "^(([Rr][Ee]?(\[[0-9]+\])?: *)?(\[[^]]+\] *)?)*"
                    # Tidy up emails significantly
                    set display_filter="perl -0777pe 's/___{10,}[^_]*microsoft teams meeting.*to join the meeting<([^>]*).*(___{10,})/\\n────────────────────────────────────────────────────────────────────────\\n\\nTeams Meeting ~~\\n\\nMeeting URL:\\n$1\\n\\n────────────────────────────────────────────────────────────────────────/is'| sed 's/^\\(To\\|CC\\): \\([^<]*[^>]\\)$/\\1\:<\\2>/g' | perl -0777pe 's/(((?!.*CC:)To:|CC:).+?(?=>\\n)>)/$1!REMOVE_ME!\\n!END!/gs' | sed '/^To:/{;:l N;/!END!/b; s/\\(\\n\\|  *\\|\\t\\t*\\)/ /g; bl}' | sed '/^To:/,/>$/ s/\\([^>]*>,\\?\\)/\\1\\n/g' | sed -e 's/^ \\(CC:\\)\\(.*$\\)/\\1\\n\\2/' -e 's/^\\(To:\\)\\(.*$\\)/\\1 --------------------------------------------------------------------\\n\\2/' -e 's/^!END!$/------------------------------------------------------------------------/' -e '/!REMOVE_ME!/d' -e '/\\[-- Type: text.* --\\]/d' -e '/\\[-- Autoview.* --\\]/d' -e '/\\[-- Type.* --\\]/d' -e '/\\[-- .*unsupported.* --\\]/d' -e '/\\[-- Attachment #[0-9] --\\]/d' -e 's/Attachment #[0-9]: //g' -e '/./,/^$/!d' -e 's/\\([A-Z]*\\), *\\([A-Za-z]*\\)\\(\"\\)\\?/\\2 \\L\\u\\1\\E\\3/g'"

              #     #### Notmuch Config
              #     set nm_query_type=threads                                   # bring in the whole thread instead of just the matched message, really useful
              #     set nm_record_tags = "sent"                                 # default 'sent' tag
              #     set virtual_spoolfile=yes                                   # allow using virtual mailboxes as spoolfile 
              macro index \Cg "<enter-command>unset wait_key<enter><shell-escape>read -p 'Enter a search: ' x; echo \$x >~/.cache/mutt_terms<enter><change-folder>All Accounts<enter><limit>~i \"\`notmuch --config ~/.config/notmuch/notmuchrc search --output=messages \$(/bin/cat ~/.cache/mutt_terms) | head -n 1000 | perl -le '@a=<>;chomp@a;s/\^id:// for@a;$,=\"|\";print@a' | sed 's/id://g' \`\"<enter>" "Search all mailboxes in all accounts (Global search)"

                    #### Content/Autoview
                    auto_view application/ics
                    auto_view text/calendar
                    auto_view text/plain
                    auto_view text/html
                    auto_view application/pgp-encrypted
                    alternative_order text/calendar application/ics text/plain text/enriched text/html

                    #### Thread ordering
                    set use_threads=reverse
                    set sort='last-date'
                    set collapse_all = yes
                    set uncollapse_new = no
                    set thread_received = yes
                    set narrow_tree=no

                    #### Lists
                    set auto_subscribe

                    ### Sounds
                    set beep=no  # don't beep for errors
                    set beep_new # beep for new messages

                    #### Text editor
                    set editor="mutt-trim %s; nvim +':set textwidth=72' +':set wrapmargin=0' +':set wrap' +':set spell' %s"

                    #### Markdown to html email conversion
                    macro compose M "F pandoc -s -f markdown -t html \ny^T^Utext/html; charset=UTF-8\n" "Convert from MD to HTML"

                    #### Show patch files (requires git-split-diffs)
                    macro attach P "|git-split-diffs --color | less -RF<enter>" "View a patch file as a diff"
                    set wait_key=no

                    # this is a bit of a hack which you may not want/need
                    timeout-hook 'exec sync-mailbox' # sync mailbox whenever idle
        '';
    };
    xdg = {
      configFile."neomutt/styles.muttrc".text =
        with config.lib.stylix.colors.withHashtag; # muttrc
        ''
          # Nerd icons idea based on https://github.com/sheoak/neomutt-powerline-nerdfonts/
          # Dracula colors based on Dracula Theme by Paul Townsend <paul@caprica.org>

          set color_directcolor

          # Formatting   ----------------------------------------------------------------------
          set date_format = "%a %d %h %H:%M"
          set index_format="  %zc %zs %zt | %-35.35L   %@attachment_info@  %-30.100s %> %?Y?%Y ? %(!%a %d %h %H:%M)  "
          set pager_format="%n %T %s%*  %{!%d %b · %H:%M} %?X? %X?%P"
          set status_format = " %D %?u? %u ?%?R? %R ?%?d? %d ?%?t? %t ?%?F? %F ?%?p? %p? \n  \n"
          set compose_format="-- NeoMutt: Compose  [Approx. msg size: %l   Atts: %a]%>-"
          # not addressed to me, only to me, appear in To:, appear in CC, \
          # sent by me, mailing list, appear in Reply-To
          set to_chars="  "

          # mail is tagged, important, deletion, attachments marked for deletion, \
          # been replied to, old, new, thread old, thread new, %S expando, %Z expando
          set flag_chars = "    "

          # unchanged mailbox, changed, read only, attach mode
          set status_chars = " +"
          #signed and verified, PGP encrypted, signed, PGP public key, no crypto info
          ifdef crypt_chars set crypt_chars = " "

          set hidden_tags = "unread,draft,flagged,passed,replied,attachment,signed,encrypted"
          tag-transforms "replied" "↻ "  \
          "encrytpted" "" \
          "signed" "" \
          "attachment" "" \

          # The formats must start with 'G' and the entire sequence is case sensitive.
          tag-formats "replied" "GR" \
          "encrypted" "GE" \
          "signed" "GS" \
          "attachment" "GA" \

          set sidebar_visible = no
          set sidebar_short_path
          set sidebar_width = 25
          set sidebar_divider_char = '│'
          set sidebar_short_path
          set sidebar_delim_chars="/"
          set sidebar_folder_indent
          set sidebar_indent_string="  "

          set sidebar_format = "%B  %* %?F? ? %?N? ? %4S "

          set vfolder_format = " %N %?n?%3n&   ?  %8m  · %f"

          set attach_format = "%T%-65.65d %> %m/%M (%s)"

          set date_format = "%d %b %H:%M"

          set folder_format = "%2C %t %N %F %2l %-8.8u %-8.8g %8s %d %i"

          # whitespaces are important! directional emojis used as "control characters"
          set status_format = "\
          INDEX \
          \
          %f\
          \
          %?r?| %r?\
          %> \
          \
          %?d?  %d?%?d?  ?\
          %?n?  %n?%?n?  ?\
          %?p?  %p?%?p?  ?\
          %?F?  %F?%?F?  ?\
          %?t?  %t?%?t?  ?\
            %m\
          \
           %P \
          %l \
          "

          set pager_format= "\
          PAGER \
          \
          %?X? ?\
          %s \
          %* \
           \
          %T \
          \
          %n\
          \
           %P \
          %cr \
          "

          set compose_format = "\
          COMPOSE \
          \
          \
          %> \
          \
          %?a?  %a?\
          \
           %l \
          "

          # General Colors   ------------------------------------------------------------------
          color normal ${base05} ${base00}                            # general text
          color error ${base08} ${base09}                           # error messages
          color message ${base05} ${base00}                           # messages at the bottom
          color prompt ${base05} ${base00}                            # prompt text
          color search ${base00} ${base0B}                              # search highlight

          # Index Colors   ------------------------------------------------------------------
          color status ${base01} ${base01}

          color status ${base01} ${base07}  '(.*?)' 1      # INDEX, PAGER
          color status ${base00} ${base00}  '(.*?)' 1      # COMPOSE
          color status ${base01} ${base02}  'Help for.*?%)' # Help status
          color status ${base03} ${base01}  '(.*?)' 1
          color status ${base00} ${base02}  '\ \+ '
          color status ${base03} ${base01}  '(.*?)' 1
          color status ${base0A} ${base01}  ' (.*?)' 1
          color status ${base01} ${base05}  '(. \S+.)' 1
          color status ${base00} ${base05}  '\s\S+.$'


          # Index Colors   --------------------------------------------------------------------
          color index ${base05} ${base00} '~N'                  # new messages
          color index ${base04} ${base00} '~R'                  # read messages
          color index ${base0E} ${base00} '~Q'                  # messages which have been replied to
          color index_collapsed ${base05} ${base00}             # collapsed thread (message count text)
          color index ${base04} ${base00} '!~Q^~p'              # sent only to me and haven't been replied to
          color index ${base0A} ${base00} '~h X-Label..'        # messages with a complete label
          color index ${base0B} ${base00} '~F'                  # flagged messages
          color index ${base0B} ${base00} '~F~N'                # flagged messages (new)
          color index ${base0C} ${base00} '~F~R'                 # flagged messages (read)
          color index ${base08} ${base00} '~D'                  # deleted messages
          color index ${base08} ${base00} '~D~N'                # deleted messages (new)
          color index ${base09} ${base00} '~D~R'                # deleted messages (read)
          color index ${base06} ${base00} '~T'                  # tagged messages
          color index ${base06} ${base00} '~T~N'                # tagged messages (new)
          color index ${base07} ${base00} '~T~R'                 # tagged messages (read)
          color tree  ${base04} ${base04}                          # thread tree lines/arrow
          color indicator ${base0D} ${base01}                   # selection indicator
          color index_date ${base0E} ${base00}                    # date is always the same colour
          color index_label ${base0E} ${base00}                   # label is always the same colour


          # Sidebar Colors   ------------------------------------------------------------------
          color sidebar_highlight       ${base01}   ${base05}
          color sidebar_unread    bold  ${base0D}   ${base00}
          color sidebar_spoolfile       ${base0C}   ${base00}
          color sidebar_new             ${base0C}   ${base00}
          color sidebar_ordinary        ${base0C}   ${base00}
          color sidebar_flagged         ${base0C}   ${base00}


          # Message Headers   -----------------------------------------------------------------
          color hdrdefault ${base07} ${base01}


          # Message Body   --------------------------------------------------------------------

          # Attachments
          color attachment ${base08} ${base00}

          # Signature
          color signature ${base07} ${base00}

          # emails
          # color body  color14 default  '[\-\.+_a-zA-Z0-9]+@[\-\.a-zA-Z0-9]+'

          # hide "mailto" 
          color body  ${base0A} ${base00}  '<mailto:[\-\.+_a-zA-Z0-9]+@[\-\.a-zA-Z0-9]+>'

          # URLs
          color body  ${base0A} ${base00}  '(https?|ftp)://[-\.,/%~_:?&=\#a-zA-Z0-9\+]+'

          # Dividers
          color body ${base04} ${base00} '(^[-_]*$)'

          # Important info in calendar invites
          color body ${base09} ${base00} '^(Date\/Time|Location|Organiser|Invitees|Teams Meeting)(:| \~\~)'

          # Quotes
          color quoted    ${base0F}   ${base00}
          color quoted1    ${base0E}  ${base00}
          color quoted2    ${base07}   ${base00}
          color quoted3    ${base0C}   ${base00}
          color quoted4    ${base09}   ${base00}

          # Forward/reply headers
          color body color8 default '(^(To|From|Sent|Subject):.*)'

          # Patch syntax highlighting
          color   body    ${base0D}    ${base00}    '^[[:space:]].*'
          color   body    ${base0A}    ${base00}    ^(diff).*
          color   body    ${base05}    ${base00}    ^[\-\-\-].*
          color   body    ${base05}    ${base00}    ^[\+\+\+].*
          color   body    ${base0B}    ${base00}    ^[\+].*
          color   body    ${base04}    ${base00}    ^[\-].*
          color   body    ${base06}    ${base00}    [@@].*
          color   body    ${base07}    ${base00}    ^(Signed-off-by).*
          color   body    ${base0D}    ${base00}    ^(Cc)
          color   body    ${base0A}    ${base00}    "^diff \-.*"
          color   body    ${base0D}    ${base00}    "^index [a-f0-9].*"
          color   body    ${base06}    ${base00}    "^---$"
          color   body    ${base05}    ${base00}    "^\-\-\- .*"
          color   body    ${base05}    ${base00}    "^[\+]{3} .*"
          color   body    ${base0B}    ${base00}    "^[\+][^\+]+.*"
          color   body    ${base09}    ${base00}    "^\-[^\-]+.*"
          color   body    ${base06}    ${base00}    "^@@ .*"
          color   body    ${base0B}    ${base00}    "LGTM"
          color   body    ${base0E}    ${base00}    "-- Commit Summary --"
          color   body    ${base0E}    ${base00}    "-- File Changes --"
          color   body    ${base0E}    ${base00}    "-- Patch Links --"
          color   body    ${base0B}    ${base00}    "^Merged #.*"
          color   body    ${base09}    ${base00}    "^Closed #.*"
          color   body    ${base06}    ${base00}    "^Reply to this email.*"


          # Misc  -----------------------------------------------------------------------------

          # no addressed to me, to me, group, cc, sent by me, mailing list
          set to_chars=" "

          # unchanged mailbox, changed, read only, attach mode
          set status_chars = " "
          ifdef crypt_chars set crypt_chars = " "
          set flag_chars = "      "

           # don't put '+' at the beginning of wrapped lines
           set markers=no
        '';
      configFile."neomutt/keys/" = {
        source = ./keys;
        recursive = true;
      };
      configFile."neomutt/mailcap".text = ''
        # open html emails in browser (or whatever GUI program is used to render HTML)
        text/html; openfile %s ; nametemplate=%s.html
        # render html emails inline using magic (uncomment the line below to use lynx instead)
        # text/html; lynx -assume_charset=%{charset} -display_charset=utf-8 -collapse_br_tags -dump %s; nametemplate=%s.html; copiousoutput
        text/html; ${
          pkgs.writers.writeBash "beautiful_html_render" # bash
            ''
              #!/usr/bin/env bash
              # render html as markdown and display in glow, supports syntax highlighting
              # requires: html2text, glow
              # author: CEUK
              perl -0777pe 's/(<code class="sourceCode\s?)(\w+?)(">)(.*?)(<\/code>)/\1\2\3\n```\2\n\4\n```\n\5/gs' "$1" | html2text | sed -re 's/^\s+(```(\w+)?)/\1/gm' > /tmp/mutt.md
              glow -s ~/.config/glow/email.json /tmp/mutt.md | sed 's/\x1b\[[6-9;]*m//g'
            ''
        } %s; nametemplate=%s.html; copiousoutput;

        # show calendar invites
        #text/calendar; render-calendar-attachment.py %s; copiousoutput;
        #application/ics; mutt-viewical; copiousoutput;

        # open images externally
        image/*; openfile %s ;

        # open videos in mpv
        video/*; mpv --autofit-larger=90\%x90\% %s; needsterminal;
        video/*; setsid mpv --quiet %s &; copiousoutput

        # open spreadsheets in sc-im
        application/vnd.openxmlformats-officedocument.spreadsheetml.sheet; sc-im %s; needsterminal

        # open anything else externally
        application/pdf; openfile %s;
      '';
    };

    home.persistence = lib.mkIf osConfig.optinpermanence.enable {
      "/persist/home/${config.home.username}/neomutt" = {
        directories = [ ".cache/neomutt" ];
        allowOther = false;
      };
    };
  };
}
