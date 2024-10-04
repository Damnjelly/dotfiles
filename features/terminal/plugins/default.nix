{
  pkgs,
  lib,
  osConfig,
  ...
}:
{
  programs.fzf = lib.mkIf osConfig.features.terminal.enable {
    enable = true;
    defaultOptions = [
      "--border sharp"
      "--preview '${pkgs.bat}/bin/bat --color=always {}'"
    ];
  };
}
