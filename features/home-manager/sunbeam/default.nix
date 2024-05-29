{ pkgs, outputs, ... }: {
  imports = [ outputs.homeManagerModules.sunbeam ./sunbeam.nix ];
  home.packages = with pkgs; [
    deno
    bluetuith
    nix-search-cli
    stable.j4-dmenu-desktop
    pulseaudio
  ];
}
