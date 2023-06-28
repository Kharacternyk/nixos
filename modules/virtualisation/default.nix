{ lib, host, ... }: lib.optionalAttrs (host ? hasEnoughRam) {
  virtualisation.docker.rootless.enable = true;
  environment.variables.DOCKER_HOST = "unix:///run/user/1000/docker.sock";
}
