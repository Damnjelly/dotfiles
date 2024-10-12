{ config, lib, ... }:
{
  options.features.immich.enable = lib.mkEnableOption "immich";

  config = lib.mkIf config.features.immich.enable {
    services.immich = {
      enable = true;
      openFirewall = true;
      host = config.networking.defaultGateway.address;
    };
  };
}
