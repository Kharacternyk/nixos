{
  readAttributes = lib: file: set:
    let inherit (lib) filter isString readFile splitString getAttrFromPath; in
    map (attribute: getAttrFromPath (splitString "." attribute) set) (
      filter (attribute: isString attribute && attribute != "") (
        splitString "\n" (
          readFile file
        )
      )
    );
}
