{ lib, modulesPath, ... }: {
  imports = [
    "${modulesPath}/virtualisation/amazon-image.nix"
  ];
  hardware.graphics.enable = true;
  services = {
    amazon-ssm-agent.enable = lib.mkForce false;
    xserver.videoDrivers = [
      "nvidia"
    ];
  };
  system.stateVersion = "22.05";
}
