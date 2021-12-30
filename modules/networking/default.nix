{ hostname, headless, ... }: {
  networking = {
    hostName = hostname;
  } // (if headless then { } else {
    useDHCP = false;
    networkmanager.enable = true;
  });
}
