{ host, pkgs, ... }:
let
  makeBackupScript = name: flags: pkgs.writeShellScriptBin name ''
    ${pkgs.rsync}/bin/rsync -vba --suffix="~$(date +%s)~" --exclude='*~' ${flags}\
      "$2/klunok/store/" "$1/klunok/store/"
  '';
  backup = makeBackupScript "backup" "";
  check = pkgs.writeShellScriptBin "check" ''
    diff --color=always -r "$2/klunok/store" "$1/klunok/store"
  '';
in
{
  environment.systemPackages = [
    check
    backup
    (makeBackupScript "backup-rsudo" "-e 'ssh -A' --rsync-path='sudo rsync'")
  ];
  systemd = {
    services.backup = {
      requires = [
        "backup.mount"
      ];
      script = "${backup}/bin/backup /backup";
      serviceConfig.Type = "oneshot";
    };
    timers.backup = {
      enable = host ? hasBackup;
      timerConfig = {
        OnCalendar = "*:00/15";
        Unit = "backup.service";
      };
      wantedBy = [
        "timers.target"
      ];
    };
  };
}
