{ config, lib, pkgs, inputs, ... }: {
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
    ./../../features/nixos/sops.nix
  ];

  theme = "madotsuki";

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
      "/etc/NetworkManager/system-connections"
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

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];

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

  nix.settings = {
    # Enable flakes and new 'nix' command
    experimental-features = "nix-command flakes";
    # Deduplicate and optimize nix store
    auto-optimise-store = true;
  };

  hardware = {
    # Enable opentabletdriver
    opentabletdriver.enable = true;
    opentabletdriver.daemon.enable = true;
  };

  # Enable bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  programs.steam.enable = true;

  services = {
    xserver = {
      xkb = {
        layout = "us";
        variant = "";
      };
      display = 1;
    };
    # Enable remote destop
    xrdp = { enable = true; };

    # Enable CUPS to print documents.
    printing.enable = false;

    # Enable sound with pipewire.
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
  # Enable sound with pipewire.
  sound.enable = true;

  security.rtkit.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
      gnome.gnome-keyring
    ];
  };

  networking = {
    hostName = "nixos";
    firewall = {
      enable = true;
      allowedTCPPortRanges = [{
        from = 1714;
        to = 1764;
      }]; # KDE Connect
      allowedUDPPortRanges = [{
        from = 1714;
        to = 1764;
      }]; # KDE Connect
    };
  };
# services.xserver.videoDrivers = ["nvidia"];

# hardware.nvidia = {
#   
#   modesetting.enable = true;
#   package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
#     version = "555.42.02";
#     sha256_64bit = "sha256-k7cI3ZDlKp4mT46jMkLaIrc2YUx1lh1wj/J4SVSHWyk=";
#     sha256_aarch64 = lib.fakeSha256;
#     openSha256 = "sha256-rtDxQjClJ+gyrCLvdZlT56YyHQ4sbaL+d5tL4L4VfkA=";
#     settingsSha256 = "sha256-rtDxQjClJ+gyrCLvdZlT56YyHQ4sbaL+d5tL4L4VfkA=";
#     persistencedSha256 = lib.fakeSha256;

#   };
# };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}

