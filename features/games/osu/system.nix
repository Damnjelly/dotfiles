{
  # Enable opentabletdriver
  hardware = {
    opentabletdriver.enable = false;
    uinput.enable = true;
  };

  nixpkgs.config.permittedInsecurePackages = [
    #"dotnet-runtime-6.0.428"
  ];

  nix.settings = {
    substituters = [ "https://nix-gaming.cachix.org" ];
    trusted-public-keys = [ "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" ];
  };
}
