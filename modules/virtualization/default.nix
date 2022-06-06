{ rootlessDocker, ... }: {
  virtualisation.docker.rootless.enable = rootlessDocker;
  environment.variables = if !rootlessDocker then { } else {
    DOCKER_HOST = "unix:///run/user/1000/docker.sock";
  };
}
