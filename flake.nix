{
  description = "Nixos config flake";

  inputs = {
    ags.url = "github:Aylur/ags";

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.90.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    impermanence.url = "github:nix-community/impermanence";

    niri.url = "github:sodiboo/niri-flake";

    nixpkgs-mons.url = "github:UlyssesZh/nixpkgs/everest-mons";

    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #stylix.url = "git+file:/home/gelei/Documents/stylix";
    stylix.url = "github:danth/stylix";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nixvim,
      stylix,
      disko,
      sops-nix,
      nixos-wsl,
      lix-module,
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
            ./systems/nightglider/configuration.nix
            lix-module.nixosModules.default
          ];
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
          modules = [ ./systems/moondancer/configuration.nix ];
        };
      };

      homeConfigurations = {
        "gelei@nightglider" = lib.homeManagerConfiguration {
          modules = [ ./systems/nightglider/gelei/home.nix ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = {
            inherit inputs outputs;
          };
        };
      };
      homeConfigurations = {
        "gelei@moondancer" = lib.homeManagerConfiguration {
          modules = [ ./systems/moondancer/gelei/home.nix ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = {
            inherit inputs outputs;
          };
        };
      };
    };
}
