{ config, lib, ... }:
{
  options.features.tailscale.enable = lib.mkEnableOption "tailscale";

  config = lib.mkIf config.features.tailscale.enable {
    networking.nameservers = [
      "1.1.1.1#one.one.one.one"
      "1.0.0.1#one.one.one.one"
    ];

    services = {
      tailscale = {
        enable = true;
        openFirewall = true;
        authKeyFile = config.sops.secrets."${config.networking.hostName}/tailscale".path;
      };

      resolved = {
        enable = true;
        dnssec = "true";
        domains = [ "~." ];
        fallbackDns = [
          "1.1.1.1#one.one.one.one"
          "1.0.0.1#one.one.one.one"
        ];
        dnsovertls = "true";
      };
    };

    sops.secrets."${config.networking.hostName}/tailscale" = { };
    environment.persistence = lib.mkIf config.optinpermanence.enable {
      "/persist/system" = {
        directories = [
          "/var/lib/tailscale"
        ];
      };
    };
  };
}
