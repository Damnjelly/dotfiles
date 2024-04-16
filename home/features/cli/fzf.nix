{ pkgs, ... }: {
  programs.fzf = {
    enable = true;
    package = pkgs.fzf;
    defaultOptions = [ "--border sharp" "--preview 'bat --color=always {}'" ];
  };
}
