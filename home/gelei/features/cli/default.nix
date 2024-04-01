{pkgs, ...}: {
  imports = [
    ./bash.nix
    ./btop.nix
    ./fastfetch.nix
    ./kitty.nix
    ./starship.nix
    ./zellij.nix
    ./yazi.nix
    ./foot.nix
  ];
  home.packages = with pkgs; [
    diskonaut # disk analyser
    exiftool # read, write, edit EXIF meta info
    fastfetch # fetcmodulesh
    ffmpegthumbnailer # video thumbnailer
    fzf # fuzzie finder
    git # version control
    jq # JSON pretty printer and manipulator
    mediainfo # info about a video or audio file
    mpv # media player
    pamixer # audio mixer
    poppler # pdf viewer
    ripgrep # better grep
    unar # archiver
    wget # web downloader
  ];
}
