{ config, lib, ... }:
let
  user = "tutter";
in
{
  options.features.tutter.enable = lib.mkEnableOption "tutter";

  config = lib.mkIf config.features.tutter.enable {
    services = {
      icecast = {
        inherit user;
        enable = true;
      };
      mpd = {
        inherit user;
        extraConfig = ''
          audio_output {
            type            "shout"
            name            "icecast"
            description     "icecast service for tutter"
            host            "localhost"
            port            "8000"
            mount           "/mpd"
            bitrate         "128"
            format          "44100:16:2"
            encoding        "mp3"
          }
        '';
      };
    };
  };
}
