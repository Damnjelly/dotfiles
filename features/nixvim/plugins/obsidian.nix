{
  pkgs,
  lib,
  config,
  ...
}:
{
  home.packages = lib.mkIf config.programs.nixvim.plugins.obsidian.enable [
    pkgs.obsidian
  ];

  programs.nixvim = {
    plugins.obsidian = {
      enable = true;
      settings = {
        dir = "~/Documents/obsidian";
        completion = {
          min_chars = 2;
          nvim_cmp = true;
        };
        new_notes_location = "current_dir";
        follow_url_func = # lua
          ''
            function(url)
            vim.fn.jobstart({"xdg-open", url})
            end
          '';
        note_frontmatter_func = # lua
          ''
            function(note)
            -- Add the title of the note as an alias.
            if note.title then
            note:add_alias(note.title)
            end

            local out = { id = note.id, aliases = note.aliases, tags = note.tags }

            -- `note.metadata` contains any manually added fields in the frontmatter.
            -- So here we just make sure those fields are kept in the frontmatter.
            if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
            for k, v in pairs(note.metadata) do
            out[k] = v
            end
            end

            return out
            end
          '';
        note_id_func = # lua
          ''
            function(title)
            -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
            -- In this case a note with the title 'My new note' will be given an ID that looks
            -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
            local suffix = ""
            if title ~= nil then
            -- If title is given, transform it into valid file name.
            suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
            else
            -- If title is nil, just add 4 random uppercase letters to the suffix.
            for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
            end
            end
            return tostring(os.date("%a-%x")) .. "-" .. suffix
            end
          '';
      };
    };
    keymaps = [
      {
        action = "<cmd>ObsidianSearch<CR>";
        key = "<leader>of";
      }
      {
        action = "<cmd>ObsidianNew<CR>";
        key = "<leader>on";
      }
    ];
  };
}
