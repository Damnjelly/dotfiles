{
  pkgs,
  inputs,
  lib,
  config,
  ...
}:
let
  cfg = config.features.games.servers.minecraft;
in
{
  options = with lib; {
    features.games.servers.minecraft = {
      enable = mkEnableOption "minecraft";
      projectArchitect2.enable = mkEnableOption "projectArchitect2";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.temurin-jre-bin-17 ];
    nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

    services.minecraft-servers = {
      enable = true;
      eula = true;

      servers = {
        projectArchitect2 = {
          enable = cfg.projectArchitect2.enable;
          package = pkgs.vanillaServers.vanilla-1_20_1;

          serverProperties = {
            gamemode = "survival";
            difficulty = "hard";
            simulation-distance = 10;
            server-port = 25566;
          };

          whitelist = {
            Juinen = "7f9a79ad-e4ac-4bdd-9217-4afe3f8c328d";
          };

          jvmOpts = "-Xms8184M -Xmx8184M -XX:+UseG1GC";
        };
      };
    };
    networking.firewall = {
      enable = true;
      allowedTCPPorts = [ 25565 ];
      allowedUDPPorts = [ 25565 ];
    };
  };
}
