{ pkgs, ... }:
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
            settings.formatting.command = [ "nixpkgs-fmt" ];
            extraOptions = {
              offset_encoding = "utf-8";
            };
          };
          bashls.enable = true;
          rust_analyzer = {
            enable = true;
            installCargo = true;
            installRustc = true;
          };
          pylyzer.enable = true;
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
