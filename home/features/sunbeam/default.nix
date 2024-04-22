{ pkgs, ... }: {
  imports = [ ./sunbeam.nix ];
  home.packages = with pkgs; [ deno stable.j4-dmenu-desktop pulseaudio ];
}
