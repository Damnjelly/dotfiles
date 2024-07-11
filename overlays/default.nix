{ inputs, ... }:
{
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs { pkgs = final; };

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    qutebrowser = prev.qutebrowser.overrideAttrs (old: {
      nativeBuildInputs = old.nativeBuildInputs ++ [ prev.python3.pkgs.distlib ];
    });
    #   niri-unstable = prev.niri-unstable.overrideAttrs (old: {
    #     src = final.fetchFromGitHub {
    #       owner = "Damnjelly";
    #       repo = "niri";
    #       rev = "779327a9ec8b7fac8780d9733fac4dc1c3cbb5f8";
    #       hash = "sha256-ccWQB+7URPYC0N0Jbzoi2cTjECSr42UsA2kKTOHe2oo=";
    #     };
    #   });
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
