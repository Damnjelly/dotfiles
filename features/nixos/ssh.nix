{
  programs.ssh = {
    knownHosts = {
      "github.com".publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";
      "[galaxy]:145" = {
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOXNK+8zCSAQM/OK52rfnIHY4zYhLfeAw0RNdInPMKr8";
        extraHostNames = [ "[galaxy.wyvern-wahoo.ts.net]:145" "[192.168.1.116]:145" "[100.98.198.36]:145" ];
      };
    };
  };
}
