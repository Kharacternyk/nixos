{ lib, dev, ... }: lib.optionalAttrs dev {
  virtualisation.docker.rootless.enable = true;
  environment.variables.DOCKER_HOST = "unix:///run/user/1000/docker.sock";
}
