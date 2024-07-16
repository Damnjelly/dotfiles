{ lib, ... }:
{
  home = {
    homeDirectory = lib.mkDefault "/home/gelei";
    username = lib.mkDefault "gelei";
    sessionPath = [ "$HOME/.local/bin" ];
  };

  programs.git = {
    userName = "Damnjelly";
    userEmail = "juinen@proton.me";
  };
}
