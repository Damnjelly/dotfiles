{
  pkgs,
  config,
  ...
}:
let
  image = ../../../themes/${config.theme}/fastfetch.sixel;
in
{
  programs.fastfetch = {
    enable = true;
    package = pkgs.fastfetch;
  };
  xdg.configFile."fastfetch/config.jsonc".text = # jsonc
    ''
      // Inspired by Catnap
        {
            "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
            "logo": {
                "type": "sixel",
                "source": "${image}",
                "width": 20,
                "height": 10,
                "padding": {
                    "top": 1
                }
            },
            "display": {
                "separator": " "
            },
            "modules": [
                {
                    "key": "╔═══════════╗",
                    "type": "custom"
                },
                {
                    "key": "║ {#31} user    {#keys}║",
                    "type": "title",
                    "format": "{user-name}"
                },
                {
                    "key": "║ {#32}󰇅 host    {#keys}║",
                    "type": "title",
                    "format": "{host-name}"
                },
                {
                    "key": "║ {#34} distro  {#keys}║",
                    "type": "os"
                },
                {
                    "key": "║ {#35} kernel  {#keys}║",
                    "type": "kernel"
                },
                {
                    "key": "║ {#36}󰇄 desktop {#keys}║",
                    "type": "de"
                },
                {
                    "key": "║ {#32} shell   {#keys}║",
                    "type": "shell"
                },
                {
                    "key": "║ {#33}󰍛 cpu     {#keys}║",
                    "type": "cpu",
                    "showPeCoreCount": true
                },
                {
                    "key": "║ {#34}󰘚 gpu     {#keys}║",
                    "type": "gpu"
                },
                {
                    "key": "╠═══════════╣ ----------------------------------",
                    "type": "custom"
                },
                {
                    "key": "║ {#40} colors  {#keys}║",
                    "type": "colors",
                    "symbol": "square"
                },
                {
                    "key": "╚═══════════╝",
                    "type": "custom"
                }
            ]
        }
    '';
}
