# # This file defines overlays
{ inputs, ... }: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs { pkgs = final; };

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev:
    {
      j4-dmenu-desktop = prev.j4-dmenu-desktop.overrideAttrs (old: {
        version = "develop feb 2024";
        src = final.fetchFromGitHub {
          owner = "enkore";
          repo = "j4-dmenu-desktop";
          rev = "bc58c2a3740817a9283b646c6374ebadbd27bf5e";
          hash = "sha256-lm6QAOL1dm7aXxS2faK7od7vK15blidHc8u5C5rCDqw=";
        };
      });
    };
  # When applied, the stable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.stable'
  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
  mons-package = final: prev: { monspkgs = import inputs.nixpkgs-mons { system = final.system; }; };
}
