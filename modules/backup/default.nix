{
  systemd = {
    services.backup = {
      requires = [
        "backup.mount"
      ];
      script = ''
        mkdir -p /backup/klunok/var
        cp -Tnr /klunok/store /backup/klunok/store
        cp /klunok/var/journal /backup/klunok/var/journal
      '';
      serviceConfig.Type = "oneshot";
    };
    timers.backup = {
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
