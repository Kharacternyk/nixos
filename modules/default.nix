lib:
lib.pipe ./. [
  lib.readDir
  (lib.mapAttrs (name: value: if value == "directory" then import (./. + "/${name}") else { }))
  lib.attrValues
]
