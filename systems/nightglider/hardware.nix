# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  modulesPath,
  pkgs,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (import ./partitions.nix { device = "/dev/nvme0n1"; })
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_stable;

    initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "ahci"
      "usbhid"
      "usb_storage"
      "sd_mod"
    ];
    initrd.kernelModules = [ "dm-snapshot" ];
    kernelModules = [
      "amdgpu"
      "kvm-amd"
      "v4l2loopback"
    ];
    extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
    extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';

    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "max";
      };
      efi.canTouchEfiVariables = true;
    };
  };

  fileSystems."/hdd" = {
    device = "/dev/disk/by-uuid/182307c0-fcdf-4d8f-a08f-9278d86d7e00";
    fsType = "btrfs";
  };

  networking.useDHCP = lib.mkDefault true;

  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware = {
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    graphics = {
      enable32Bit = true; # For 32 bit applications
      extraPackages32 = with pkgs; [ driversi686Linux.amdvlk ];
    };

    bluetooth.enable = true;

    amdgpu = {
      amdvlk = {
        enable = true;
        supportExperimental.enable = true;
        support32Bit.enable = true;
      };
      initrd.enable = true;
      opencl.enable = true;
    };
  };
}
