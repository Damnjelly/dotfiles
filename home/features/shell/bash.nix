{ ... }: {
  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      home-rebuild = "home-manager switch --flake ~/Documents/nix-config/#gelei@nixos";
      hr = "home-manager switch --flake ~/Documents/nix-config/#gelei@nixos";

      flake-rebuild = "sudo nixos-rebuild switch --flake ~/Documents/nix-config/#nixos";
      fr = "sudo nixos-rebuild switch --flake ~/Documents/nix-config/#nixos";

      genenerations-list = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";
      gl = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";

      genenerations-delete = "sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations";
      gd = "sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations";
    };
  };
}
