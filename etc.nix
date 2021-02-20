{pkgs, ...}: {
    environment.systemPackages = with pkgs; [
        fzf
        git
        lf
        mkpasswd
        neofetch
        pywal
        ripgrep
        thefuck
        (let python-packages = packages: with packages; [
            pygments
        ]; in python3.withPackages python-packages)
    ];
    environment.etc = {
        inputrc.source = ./sources/inputrc;
        gitconfig.source = ./sources/gitconfig;
    };
    environment.variables = {
        FZF_DEFAULT_OPTS = ''
            --bind=ctrl-l:accept,change:top
            --prompt='█◤'
            --marker='◤'
            --pointer=' '
            --info=hidden
            --no-bold
            --color fg:-1,bg:-1,hl:1,fg+:0,bg+:4,hl+:0
            --color info:-1,prompt:4,spinner:1,marker:0
            --reverse
        '';
        NIX_SHELL_PRESERVE_PROMPT = "";
        LESSHISTFILE = "/dev/null";
    };
    hardware.enableAllFirmware = true;
    nixpkgs.config.allowUnfree = true;
    documentation.dev.enable = true;
    time.timeZone = "Europe/Kiev";
    i18n.defaultLocale = "en_US.UTF-8";
    location = {
        provider = "manual";
        latitude = 50.45;
        longitude = 30.52;
    };
}
