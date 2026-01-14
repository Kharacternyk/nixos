{ pkgs, ... }: {
  environment.systemPackages = [
    pkgs.docker-compose
  ];
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };
}
