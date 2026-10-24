polkit.addRule(function (action, subject) {
    if (
        subject.uid === 1000 &&
        [
            "org.freedesktop.RealtimeKit1.acquire-high-priority",
            "org.freedesktop.RealtimeKit1.acquire-real-time",
            "org.freedesktop.login1.power-off",
            "org.freedesktop.login1.power-off-multiple-sessions",
            "org.freedesktop.login1.reboot",
            "org.freedesktop.login1.reboot-multiple-sessions",
        ].indexOf(action.id) >= 0
    ) {
        return "yes";
    }

    if (
        subject.uid === 2048 &&
        subject.active &&
        subject.local &&
        [
            "org.freedesktop.NetworkManager.network-control",
            "org.freedesktop.NetworkManager.settings.modify.system",
            "org.freedesktop.NetworkManager.wifi.scan",
        ].indexOf(action.id) >= 0
    ) {
        return "yes";
    }

    if (
        subject.uid === 1984 &&
        subject.active &&
        [
            "org.freedesktop.systemd1.manage-units",
            "org.freedesktop.systemd1.manage-unit-files",
        ].indexOf(action.id) >= 0
    ) {
        return "auth_self";
    }

    return "no";
});
