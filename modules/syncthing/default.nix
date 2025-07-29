{
  services.syncthing = {
    enable = true;
    dataDir = "/home/nazar";
    overrideDevices = false;
    openDefaultPorts = true;
    settings = {
      folders."~/sync".versioning = {
        type = "staggered";
        cleanIntervalS = "3600";
        params.maxAge = builtins.toString (3600 * 24 * 30);
      };
      options = {
        localAnnounceEnabled = false;
        relaysEnabled = false;
      };
    };
    user = "nazar";
  };
}
