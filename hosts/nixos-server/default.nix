{ lib, modulesPath, ... }: {
  imports = [
    "${modulesPath}/virtualisation/amazon-image.nix"
  ];
  hardware = {
    graphics.enable = true;
    nvidia-container-toolkit.enable = true;
  };
  services = {
    amazon-ssm-agent.enable = lib.mkForce false;
    xserver.videoDrivers = [
      "nvidia"
    ];
  };
  system.stateVersion = "22.05";
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };
}
