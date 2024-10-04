{
  lib,
  inputs,
  ...
}:

with lib;

{
  # Dynamically define options for all users from myUser
  # with their respective system and home configuration options
  options.users = {
    gelei = {
      enable = mkEnableOption "gelei";
      name = mkOption {
        type = types.str;
        default = "gelei";
      };
      features = mkOption {
        type = types.attrs;
        default = { };
      };
    };
  };

  imports = [
    # Users
    ./gelei
  ];

  config.home-manager = {
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs;
    };
    sharedModules = [
      ./defaults

      # Import impermanence home-manager through the nixos input flake (i spend too long figuring out this infinite recursion)
      {
        imports = with inputs; [
          impermanence.nixosModules.home-manager.impermanence
          nixvim.homeManagerModules.nixvim
          sops-nix.homeManagerModules.sops
          ags.homeManagerModules.default
          niri.homeModules.niri
        ];
      }
    ];
  };
}
