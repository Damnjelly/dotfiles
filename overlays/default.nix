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
    rofi-wayland-unwrapped = prev.rofi-wayland-unwrapped.overrideAttrs (
      {
        patches ? [ ],
        ...
      }:
      {
        patches = patches ++ [
          (final.fetchpatch {
            url = "https://github.com/samueldr/rofi/commit/55425f72ff913eb72f5ba5f5d422b905d87577d0.patch";
            hash = "sha256-vTUxtJs4SuyPk0PgnGlDIe/GVm/w1qZirEhKdBp4bHI=";
          })
        ];
      }
    );
    #   niri-unstable = prev.niri-unstable.overrideAttrs (old: {
    #     src = final.fetchFromGitHub {
    #       owner = "Damnjelly";
    #       repo = "niri";
    #       rev = "779327a9ec8b7fac8780d9733fac4dc1c3cbb5f8";
    #       hash = "sha256-ccWQB+7URPYC0N0Jbzoi2cTjECSr42UsA2kKTOHe2oo=";
    #     };
    #   });
  };
  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
