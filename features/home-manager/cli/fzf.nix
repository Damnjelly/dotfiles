{ ... }:
{
  stylix.targets.fzf.enable = true;
  programs.fzf = {
    enable = true;
    defaultOptions = [
      "--border sharp"
      "--preview 'bat --color=always {}'"
    ];
  };
}
