{ pkgs, ... }:
{
  imports = [
    ./btop.nix
    ./fastfetch/fastfetch.nix
    ./starship.nix
    ./zellij/zellij.nix
    ./yazi/yazi.nix
    ./foot.nix
    ./fzf.nix
  ];
  home.packages = with pkgs; [
    exiftool # read, write, edit EXIF meta info
    fastfetch # fetcmodulesh
    ffmpegthumbnailer # video thumbnailer
    git # version control
    jq # JSON pretty printer and manipulator
    mediainfo # info about a video or audio file
    mpv # media player
    poppler # pdf viewer
    ripgrep # better grep
    unar # archiver
    wget # web downloader
    gum # a tool for glamorous shell scripts
    bat # cat with syntax highlighting
  ];
}
