{
    # Enable opentabletdriver
  hardware = {
    opentabletdriver.enable = true;
    uinput.enable = true;
  };

  nix.settings = {
    substituters = [ "https://nix-gaming.cachix.org" ];
    trusted-public-keys = [ "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" ];
  };
}
