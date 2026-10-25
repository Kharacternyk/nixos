{
  host,
  lib,
  ...
}:
lib.optionalAttrs (host ? hasScreen) {
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    extraConfig.pipewire.overrides."context.properties"."default.clock.allowed-rates" = [
      44100
      48000
      88200
      96000
      176400
      192000
    ];
    jack.enable = true;
  };
}
