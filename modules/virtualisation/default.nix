{
  pkgs,
  ...
}:
{
  environment.systemPackages = [
    pkgs.docker-compose
  ];
  virtualisation.podman = {
    dockerCompat = true;
    enable = true;
  };
}
