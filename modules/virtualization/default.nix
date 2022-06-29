{ dev, ... }: {
  virtualisation.docker.rootless.enable = dev;
  environment.variables = if !dev then { } else {
    DOCKER_HOST = "unix:///run/user/1000/docker.sock";
  };
}
