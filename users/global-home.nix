{ outputs, config, ... }: {
  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };
  home.persistence."/persist/home/${config.home.username}" = {
    directories = [ "Downloads" "Music" "Pictures" "Documents" "Videos" ];
    allowOther = true;
  };
  programs.git.enable = true;
  programs.ssh.addKeysToAgent = "yes";
  pam.sessionVariables = {
    SSH_AUTH_SOCK = "${builtins.getEnv "XDG_RUNTIME_DIR"}/ssh-agent.socket";
  };
  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
