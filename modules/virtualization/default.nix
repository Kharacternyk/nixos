{ dev, ... }: {
  virtualisation.docker.rootless.enable = dev.docer or false;
  environment.variables = if !dev.docker or false then { } else {
    DOCKER_HOST = "unix:///run/user/1000/docker.sock";
  };
}
