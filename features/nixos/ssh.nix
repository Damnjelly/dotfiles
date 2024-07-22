{
  programs.ssh = {
    knownHosts = {
      "github.com".publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";
      "[galaxy]:145" = {
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOXNK+8zCSAQM/OK52rfnIHY4zYhLfeAw0RNdInPMKr8";
        extraHostNames = [ "[galaxy.wyvern-wahoo.ts.net]:145" "[192.168.1.116]:145" "[100.98.198.36]:145" ];
      };
      "[galaxy]:23231" = {
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOXSxVAb4UZuiC60UbcngAkYUlyLB0/ZAl80m7EG1tiV";
        extraHostNames = [ "[galaxy.wyvern-wahoo.ts.net]:23231" "[192.168.1.116]:23231" "[100.98.198.36]:23231" ];
      };
      "[moondancer]:145" = {
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF+lRUDWTBLmq4wLkNA+Iifw1pT0ZSigCdLke8z3pPf+";
        extraHostNames = [ "[moondancer.wyvern-wahoo.ts.net]:145" "[192.168.1.179]:145" "[100.76.99.17]:145" ];
      };
    };
  };
}
