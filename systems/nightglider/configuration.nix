{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
    inputs.disko.nixosModules.default
    inputs.impermanence.nixosModules.impermanence
    inputs.home-manager.nixosModules.home-manager
    inputs.stylix.nixosModules.stylix

    ./hardware-configuration.nix
    ./gelei/config.nix
    ./../global-config.nix
    (import ./disko.nix { device = "/dev/nvme0n1"; })

    ./../../features/nixos/boot/default.nix
    ./../../features/nixos/system-packages.nix
    ./../../features/nixos/ssh.nix
  ];

  # system name
  networking.hostName = "nightglider";

  theme = "madotsuki";
  optinpermanence.enable = true;

#   services.xserver.videoDrivers = ["nvidia"];

#   hardware.nvidia = {
#     modesetting.enable = true;
#     powerManagement.enable = false;
#     powerManagement.finegrained = false;
#     open = false;
#     nvidiaSettings = true;
#     package = config.boot.kernelPackages.nvidiaPackages.latest;
#   };
  programs.fuse.userAllowOther = true;
  fileSystems."/persist".neededForBoot = true;
  environment.persistence."/persist/system" = {
    hideMounts = true;
    directories = [
      "/etc/nixos/"
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/var/lib/alsa"
      "/etc/NetworkManager/system-connections"
      "/var/lib/tailscale"
      "/usr/local" #TODO: find a declarative way of putting these bin files here

    ];
    files = [ "/etc/machine-id" ];
  };

  systemd.tmpfiles.rules = [
    "d /persist/home/ 0777 root root-"
    "d /persist/home/gelei/ 0700 gelei users-"
  ];

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
    FLAKE = "/etc/nixos/";
  }; 

  security.polkit.enable = true;
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    # settings to get obs virtual camera working
    kernelModules = [ "v4l2loopback" ];
    extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
    extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    initrd.postDeviceCommands = lib.mkAfter ''
      mkdir /btrfs_tmp
      mount /dev/root_vg/root /btrfs_tmp
      if [[ -e /btrfs_tmp/root ]]; then
      mkdir -p /btrfs_tmp/old_roots
      timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
      mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
      fi

      delete_subvolume_recursively() {
        IFS=$'\n'
        for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
        delete_subvolume_recursively "/btrfs_tmp/$i"
        done
        btrfs subvolume delete "$1"
      }

      for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
      delete_subvolume_recursively "$i"
      done

      btrfs subvolume create /btrfs_tmp/root
      umount /btrfs_tmp
    '';
  };

  hardware = {
    # Enable opentabletdriver
    opentabletdriver.enable = true;
    opentabletdriver.daemon.enable = true;
  };

  programs.steam.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];
    configPackages = with pkgs; [
      gnome.gnome-session
      gnome.gnome-keyring
    ];
  };
#   services.xserver.videoDrivers = ["nvidia"];

#   hardware.nvidia = {
#     modesetting.enable = true;
#     powerManagement.enable = false;
#     powerManagement.finegrained = false;
#     open = false;
#     nvidiaSettings = true;
#     package = config.boot.kernelPackages.nvidiaPackages.latest;
#   };

  # https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
