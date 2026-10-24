lib:
let
  keys = lib.pipe ./. [
    lib.readDir
    (lib.mapAttrs (name: value:
      if value == "directory" then
        let
          readFile = fileName: lib.pipe (./. + "/${name}/${fileName}") [
            lib.readFile
            lib.trim
          ];
        in
        {
          inherit name;
          u2f = readFile "u2f.txt";
          ssh = readFile "ssh.txt";
        }
      else null
    ))
    (lib.attrValues)
    (lib.filter lib.isAttrs)
  ];
in
{
  ssh = lib.pipe keys [
    (map (key: "sk-ssh-ed25519@openssh.com ${key.ssh} ${key.name}"))
    lib.concatLines
    (lib.toFile "authorized_keys")
  ];
  u2f = primaryKey: users: lib.pipe keys [
    (lib.sort (a: b: a.name == primaryKey && b.name != primaryKey))
    (map (key: "*,${key.u2f},es256,+presence"))
    (lib.concatStringsSep ":")
    (u2f: map (user: "${user}:${u2f}") users)
    lib.concatLines
    (lib.toFile "u2f.txt")
  ];
}
