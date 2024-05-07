{ ... }: {
  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      genenerations-list =
        "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";
      gl =
        "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";

      genenerations-delete =
        "sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations";
      gd =
        "sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations";
    };
    initExtra = ''
      . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
    '';
  };
}
