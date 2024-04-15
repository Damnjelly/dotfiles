{ pkgs, ... }: 
let
  smarttilefix = builtins.fetchurl {
    url = "https://gist.githubusercontent.com/EdenQwQ/a0c700315f6c704d03badfab6d6e45ce/raw/bb91d00b87ff32fed154d3880890953f1ff326e7/smart-tile.py";
    sha256 = "sha256:0amz7kshijdzv81g83pl474gis29qz6a4kcfds7avw2bavcmxqi8";
  };
in {
  home = {
    packages = with pkgs; [
      python3
      sd 
    ];
    file = { 
      ".config/hypr" = {
        recursive = true;
        source = fetchGit {
          url = "https://github.com/edenqwq/smart-tiling.git";
          rev = "a6ef8cfde7375567d52b9e21130caf1e17c0581d";
        };
      };
      ".config/hypr/scripts/smart-tile.py".text = builtins.readFile "${smarttilefix}";
    };
  };
}
