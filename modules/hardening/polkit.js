polkit.addRule(function (action, subject) {
    if (subject.user !== "root" && subject.user !== "wheel") {
        return polkit.Result.NO;
    }
    // Unit-file authorization also implies permission to manage units.
    if (action.id.indexOf("org.freedesktop.systemd1.") === 0) {
        return polkit.Result.AUTH_ADMIN;
    }
});
