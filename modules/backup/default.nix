{ host, pkgs, ... }:
let
  script = pkgs.writeShellScriptBin "backup" ''
    if [[ -n $1 ]]; then
      mkdir -p "$1/klunok/var"
      cp -Tnr /klunok/store "$1/klunok/store"
      cp /klunok/var/journal "$1/klunok/var/journal"
    fi
  '';
in
{
  environment.systemPackages = [
    script
  ];
  systemd = {
    services.backup = {
      requires = [
        "backup.mount"
      ];
      script = "${script}/bin/backup /backup";
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
