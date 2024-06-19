{ pkgs, outputs, lib, config, ... }:
{
  imports = [
    outputs.homeManagerModules.sunbeam
    ./sunbeam.nix
  ];
  home.packages = with pkgs; [
    deno
    bluetuith
    nix-search-cli
    stable.j4-dmenu-desktop
    pulseaudio
    bkt
    bitwarden-cli
  ];
  home.persistence = lib.mkIf config.optinpermanence.enable {
    "/persist/home/${config.home.username}/Sunbeam" = {
      files = [ ".config/Bitwarden CLI/data.json" ];
    };
  };
}
