let inherit (builtins) filter isString map readFile split; in {
  readAttributes = file: set:
    map (attribute: set.${attribute}) (
      filter (attribute: isString attribute && attribute != "") (
        split "\n" (
          readFile file
        )
      )
    );
}
