[[ -n $(loginctl list-sessions --no-legend) ]] && exit
pgrep tmux >/dev/null && exit

logout_line="$(journalctl -u systemd-logind -g 'Removed session' -n 1 -o short-unix)"

[[ -z "$logout_line" ]] && exit

now="$(date +%s)"
last_logout="${logout_line%% *}"
last_logout="${last_logout%%.*}"

[[ $((now - last_logout)) -lt $((30 * 60)) ]] && exit

systemctl poweroff
