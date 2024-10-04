{
  osConfig,
  lib,
  config,
  ...
}:
{
  imports = [
    ../../features/home.nix
  ];

  home.persistence = lib.mkIf osConfig.optinpermanence.enable {
    "/persist/home/${config.home.username}" = {
      directories = [
        "Downloads"
        "Music"
        "Pictures"
        "Documents"
        "Videos"
      ];
      allowOther = true;
    };
  };

  programs.git.enable = true;

  programs.ssh.addKeysToAgent = "yes";
  pam.sessionVariables = {
    SSH_AUTH_SOCK = "${builtins.getEnv "XDG_RUNTIME_DIR"}/ssh-agent.socket";
  };
  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  sops =
    let
      sysSops = osConfig.sops;
    in
    {
      defaultSopsFile = sysSops.defaultSopsFile;
      defaultSopsFormat = sysSops.defaultSopsFormat;
      age.keyFile = sysSops.age.keyFile;
    };

  home.stateVersion = "24.05";
}
