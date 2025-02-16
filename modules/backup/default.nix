{ host, pkgs, ... }:
let
  script = pkgs.writeShellScriptBin "backup" ''
    ${pkgs.rsync}/bin/rsync -vba --suffix="~$(date +%s)~" --exclude='*~' \
      "$2/klunok/store/" "$1/klunok/store/"
  '';
  check = pkgs.writeShellScriptBin "check" ''
    diff --color=always -r "$2/klunok/store" "$1/klunok/store"
  '';
in
{
  environment.systemPackages = [
    check
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
