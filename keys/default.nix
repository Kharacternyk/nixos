lib:
let
  keys = lib.pipe ./. [
    lib.readDir
    (lib.filterAttrs (_: type: type == "directory"))
    (lib.mapAttrsToList (name: _:
      let
        readFile = fileName: lib.pipe (./. + "/${name}/${fileName}") [
          lib.readFile
          lib.trim
        ];
      in
      {
        inherit name;
        ssh = readFile "ssh.txt";
        u2f = readFile "u2f.txt";
      }
    ))
  ];
in
{
  ssh = lib.pipe keys [
    (lib.concatMapStrings (key: "sk-ssh-ed25519@openssh.com ${key.ssh} ${key.name}\n"))
    (lib.toFile "authorized_keys")
  ];
  u2f = primaryKey: users: lib.pipe keys [
    (lib.sort (a: b: a.name == primaryKey && b.name != primaryKey))
    (lib.concatMapStringsSep ":" (key: "*,${key.u2f},es256,+presence"))
    (u2f: lib.concatMapStrings (user: "${user}:${u2f}\n") users)
    (lib.toFile "u2f.txt")
  ];
}
