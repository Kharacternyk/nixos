{ lib, ... }: {
  fileSystems = lib.getAttrs [ "/" "/backup" ] (label: { inherit label; });
}
