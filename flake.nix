{
  description = "Nixos config flake";

  inputs = {
    ags.url = "github:Aylur/ags";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.1.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri.url = "github:sodiboo/niri-flake";

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    nix-gaming.url = "github:fufexan/nix-gaming";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-minecraft.url = "github:Infinidoge/nix-minecraft";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
      systems = [ "x86_64-linux" ];
      forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
      pkgsFor = lib.genAttrs systems (
        system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
      );

      standardModules = with inputs; [
        disko.nixosModules.default
        home-manager.nixosModules.home-manager
        impermanence.nixosModules.impermanence
        #lix-module.nixosModules.default
        sops-nix.nixosModules.sops
        stylix.nixosModules.stylix
        nix-minecraft.nixosModules.minecraft-servers

        ./users
        ./systems/defaults
        ./features/system.nix
      ];
    in
    {
      packages = forEachSystem (pkgs: import ./pkgs { inherit pkgs; });
      overlays = import ./overlays { inherit inputs; };
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;
      stylix = import ./modules/stylix;

      # systems
      nixosConfigurations = {
        # home desktop
        nightglider = lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [
            ./systems/nightglider/config.nix
            ./systems/nightglider/hardware.nix
          ] ++ standardModules;
        };

        # work laptop (wsl)
        starhopper = lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [ ./systems/starhopper/configuration.nix ];
        };

        # homelab
        moondancer = lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [
            ./systems/moondancer/config.nix
            ./systems/moondancer/hardware.nix
          ] ++ standardModules;
        };
      };
    };
}
