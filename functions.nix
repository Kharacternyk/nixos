{
  readAttributes = lib: file: set:
    let inherit (lib) filter readFile splitString getAttrFromPath; in
    map (attribute: getAttrFromPath (splitString "." attribute) set) (
      filter (attribute: attribute != "") (
        splitString "\n" (
          readFile file
        )
      )
    );
}
