lib:
let
  inherit (lib)
    filterAttrs
    mapAttrsToList
    pipe
    readDir
    ;
in
pipe ./. [
  readDir
  (filterAttrs (_: type: type == "directory"))
  (mapAttrsToList (name: _: import (./. + "/${name}")))
]
