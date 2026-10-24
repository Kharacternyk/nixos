{ host, lib, pkgs, ... }:
let
  makeBackupScript = name: flags: pkgs.writeShellScriptBin name ''
    ${pkgs.rsync}/bin/rsync -vba --mkpath --suffix="~$(date +%s)~" --exclude='*~' ${flags}\
      "$2/klunok/store/" "$1/klunok/store/"
  '';
  backup = makeBackupScript "backup" "";
  check = pkgs.writeShellScriptBin "check" ''
    diff --color=always -r --no-dereference "$2/klunok/store" "$1/klunok/store"
  '';
in
{
  environment.systemPackages = [
    check
    backup
    (makeBackupScript "backup-run0" "-e 'ssh -A' --rsync-path='run0 rsync'")
  ];
  systemd = lib.optionalAttrs (host ? hasBackup) {
    services = {
      backup = {
        after = [
          "backup.mount"
        ];
        requires = [
          "backup.mount"
        ];
        script = "${lib.getExe backup} /backup";
        serviceConfig.Type = "oneshot";
      };
      systemd-tmpfiles-resetup.after = [
        "backup.mount"
      ];
      systemd-tmpfiles-setup.after = [
        "backup.mount"
      ];
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
    tmpfiles.settings.backup."/backup" = "u:nazar:rx,g::---,m::rx,o::---";
  };
}
