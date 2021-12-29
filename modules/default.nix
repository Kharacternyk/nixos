builtins.attrValues (builtins.mapAttrs
  (name: value: if value == "directory" then import (./. + "/${name}") else { })
  (builtins.readDir ./.)
)
