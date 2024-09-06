{ ... }:
{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      nhh = "nh home switch";
      nho = "nh home switch";
      spot = "down_on_spot";
    };
    initExtra = ''
      . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
    '';
  };
}
