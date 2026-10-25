lib:
let
  inherit (lib)
    concatMapStrings
    concatMapStringsSep
    filterAttrs
    mapAttrsToList
    pipe
    readDir
    readFile
    sort
    toFile
    trim
    ;
  keys = lib.pipe ./. [
    readDir
    (filterAttrs (_: type: type == "directory"))
    (mapAttrsToList (
      name: _:
      let
        readKey =
          fileName:
          pipe (./. + "/${name}/${fileName}") [
            readFile
            trim
          ];
      in
      {
        inherit name;
        ssh = readKey "ssh.txt";
        u2f = readKey "u2f.txt";
      }
    ))
  ];
in
{
  ssh = pipe keys [
    (concatMapStrings (key: "sk-ssh-ed25519@openssh.com ${key.ssh} ${key.name}\n"))
    (toFile "authorized_keys")
  ];
  u2f =
    primaryKey: users:
    pipe keys [
      (sort (a: b: a.name == primaryKey && b.name != primaryKey))
      (concatMapStringsSep ":" (key: "*,${key.u2f},es256,+presence"))
      (u2f: concatMapStrings (user: "${user}:${u2f}\n") users)
      (toFile "u2f.txt")
    ];
}
