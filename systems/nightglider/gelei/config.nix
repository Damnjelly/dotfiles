{ pkgs, config, ... }:
{
  users.users.gelei = {
    hashedPasswordFile = config.sops.secrets."nightglider/gelei/pcpassword".path;
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP3oaeGTbuDpOp3ebDPmUxjV1W1sI1EzXkqxJOJCNknf juinen@proton.me
"
    ];
    extraGroups = [
      "networkmanager"
      "wheel"
      "uinput"
    ];
  };
  home-manager.users.gelei = import ./home.nix;

  hardware = {
    # Enable opentabletdriver
    opentabletdriver.enable = true;
    opentabletdriver.daemon.enable = true;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  security.polkit.enable = true;

  programs.steam.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];
    configPackages = with pkgs; [ gnome.gnome-session ];
  };

  # sops
  environment.sessionVariables.SOPS_AGE_KEY_FILE = /persist/sops/ags/keys.txt;
  sops = {
    age.keyFile = /persist/sops/ags/keys.txt;
    secrets = {
      "nightglider/gelei/pcpassword".neededForUsers = true;
      "nightglider/gelei/sshjuinened22519" = {
        owner = "gelei";
        path = "/home/gelei/.ssh/id_ed25519";
      };
      "nightglider/tailscale" = { };
    };
  };
}
