{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.desktopManagers.niri;
in
{
  options = with lib; {
    features.desktopManagers.niri = {
      enable = mkEnableOption "niri";
      enableFor = mkOption {
        type = with types; listOf str;
        default = [ ];
      };
    };
  };

  imports = [
    ./displayManager
    ./windowManager/system.nix
  ];

  # Enable niri only when enabled and a user is assigned
  config = lib.mkIf (cfg.enable && cfg.enableFor != null) {
    nixpkgs.overlays = [ inputs.niri.overlays.niri ];
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    security.polkit.enable = true;
    environment.defaultPackages = with pkgs; [
      wl-clipboard-rs
      nautilus
    ];
    xdg = {
      portal = {
        enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-gnome
          xdg-desktop-portal-gtk
        ];
        configPackages = with pkgs; [ gnome-session ];
      };
    };

    programs.gnome-disks.enable = true;
    services = {
      devmon.enable = true;
      gvfs.enable = true;
      udisks2 = {
        mountOnMedia = true;
        enable = true;
      };
    };
  };
}
