{
  environment = {
    etc.inputrc.source = ./inputrc;
    shellAliases = {
      btm = "btm --theme=default-light";
      diff = "diff --color=auto";
      egrep = "egrep --color=auto";
      ffmpeg = "ffmpeg -hide_banner";
      ffprobe = "ffprobe -hide_banner";
      fgrep = "fgrep --color=auto";
      gi = "git";
      grep = "grep --color=auto";
      lq = "lf /klunok/var/queue";
      ls = "ls --color=auto -FA";
      ncdu = "ncdu --color=dark";
      objdump = "objdump -M intel-mnemonic --visualize-jumps=color";
      rg = "rg -i";
      rsync = "rsync -au --info=progress2 --mkpath --safe-links";
    };
    variables = {
      DFT_COLOR = "always";
      DFT_SKIP_UNCHANGED = "true";
      DFT_SYNTAX_HIGHLIGHT = "off";
      FZF_DEFAULT_OPTS = builtins.readFile ./fzf_opts.few;
      LESSHISTFILE = "/dev/null";
      _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=on";
    };
  };
  programs.bash = {
    interactiveShellInit = builtins.readFile ./bashrc;
    promptInit = builtins.readFile ./prompt.sh;
  };
}
