lib:
lib.pipe ./. [
  lib.readDir
  (lib.filterAttrs (_: type: type == "directory"))
  (lib.mapAttrsToList (name: _: import (./. + "/${name}")))
]
