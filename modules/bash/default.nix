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
      grep = "grep --color=auto";
      ls = "ls --color=auto -FA";
      ncdu = "ncdu --color=dark";
      objdump = "objdump -M intel-mnemonic --visualize-jumps=color";
      sudo = "sudo ";
    };
    variables = {
      DFT_SYNTAX_HIGHLIGHT = "off";
      FZF_DEFAULT_OPTS = ''
        --bind=change:top
        --prompt='/ '
        --info=hidden
        --color fg:-1,bg:-1,hl:1,fg+:-1,bg+:-1,hl+:1
        --color prompt:4,spinner:4,marker:4,pointer:4
        --reverse
        --no-separator
      '';
      LESSHISTFILE = "/dev/null";
      _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=on";
    };
  };
  programs.bash = {
    interactiveShellInit = builtins.readFile ./bashrc;
    promptInit = builtins.readFile ./prompt.sh;
  };
}
