prefix = os.getenv("KLUNOK_PREFIX") or prefix

excluded_paths['/home/nazar'] = true
cluded_paths['/home/nazar/src'] = true
project_parents['/home/nazar/src'] = true

history_paths['/home/nazar/.bash_history'] = true
included_paths['/home/nazar/.config/qutebrowser/bookmarks'] = true
included_paths['/home/nazar/.config/REAPER/reaper.ini'] = true

included_paths['/etc/nixos'] = true
project_roots['/etc/nixos'] = true
