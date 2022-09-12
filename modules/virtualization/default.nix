{ dev, ... }: {
  virtualisation.docker.rootless.enable = dev.docker or false;
  environment.variables =
    if dev.docker or false then {
      DOCKER_HOST = "unix:///run/user/1000/docker.sock";
    } else { };
}
