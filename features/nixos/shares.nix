{ config, pkgs, ... }:
{
  sops.secrets."galaxy/gelei/smb" = { };
  environment.systemPackages = [ pkgs.cifs-utils ];
  fileSystems."/smb/galaxy/Obsidian" = {
    device = "//galaxy/Obsidian";
    fsType = "cifs";
    options =
      let
        # this line prevents hanging on network split
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

      in
      [ "${automount_opts},credentials=${config.sops.secrets."galaxy/gelei/smb".path},uid=1000,gid=100" ];
  };

  fileSystems."/smb/galaxy/Shared" = {
    device = "//galaxy/Shared";
    fsType = "cifs";
    options =
      let
        # this line prevents hanging on network split
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

      in
      [ "${automount_opts},credentials=${config.sops.secrets."galaxy/gelei/smb".path},uid=1000,gid=100" ];
  };

  fileSystems."/smb/galaxy/Jellyfin" = {
    device = "//galaxy/docker/jellyfin/data";
    fsType = "cifs";
    options =
      let
        # this line prevents hanging on network split
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

      in
      [ "${automount_opts},credentials=${config.sops.secrets."galaxy/gelei/smb".path},uid=1000,gid=100" ];
  };
}
