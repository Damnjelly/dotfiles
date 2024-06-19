{ config, ... }:
{
  networking.nameservers = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ]; 

  services = {
    tailscale = {
      enable = true;
      openFirewall = true;
      authKeyFile = config.sops.secrets."nightglider/tailscale".path;
    };

    resolved = {
      enable = true;
      dnssec = "true";
      domains = [ "~." ];
      fallbackDns = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
      dnsovertls = "true";
    };
  };
}
