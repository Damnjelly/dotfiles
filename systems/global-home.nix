{ lib, outputs, config, ... }: {
  options = with lib; {
    theme = mkOption {
      type = types.str;
      default = "madotsuki";
      example = "kanagawa";
    };
    optinpermanence.enable = mkOption {
      type = types.bool;
      default = false;
      description = "enable permanence";
    };
  };

  config = {
    nixpkgs = {
      overlays = builtins.attrValues outputs.overlays;
      config = {
        allowUnfree = true;
        allowUnfreePredicate = _: true;
      };
    };

    home = {
      persistence = lib.mkIf config.optinpermanence.enable {
        "/persist/home/${config.home.username}" = {
          directories = [ "Downloads" "Music" "Pictures" "Documents" "Videos" ];
          allowOther = true;
        };
      };

      file.".config/wpaperd/wallpapers/" = {
        source = ./../features/themes/${config.theme}/wallpapers;
        recursive = true;
      };
    };

    stylix.base16Scheme = ./../features/themes/${config.theme}/scheme.yaml;
    stylix.image =
      ./../features/themes/${config.theme}/wallpapers/wallpaper.png;
    stylix.cursor.size = 16;

    programs.wpaperd.enable = true;
    programs.git.enable = true;

    programs.ssh.addKeysToAgent = "yes";
    pam.sessionVariables = {
      SSH_AUTH_SOCK = "${builtins.getEnv "XDG_RUNTIME_DIR"}/ssh-agent.socket";
    };
    # Nicely reload system units when changing configs
    systemd.user.startServices = "sd-switch";
  };
}
