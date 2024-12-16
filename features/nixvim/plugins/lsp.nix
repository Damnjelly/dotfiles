{ pkgs, lib, ... }:
{
  programs.nixvim = {
    plugins = {
      lsp-format = {
        enable = true;
        lspServersToEnable = "all";
      };

      lsp = {
        enable = true;
        servers = {
          nixd = {
            enable = true;
            settings.formatting.command = [ "${pkgs.nixfmt-rfc-style}/bin/nixfmt" ];
            extraOptions = {
              offset_encoding = "utf-8";
            };
          };
          rust_analyzer = {
            enable = true;
            installCargo = true;
            installRustc = true;
          };
          ts_ls.enable = true;
          gdscript = {
            enable = true;
            package = pkgs.gdtoolkit_4;
          };
        };
      };
    };
  };
}
