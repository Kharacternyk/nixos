function home(string)
    return '/home/nazar/' .. string
end

prefix = os.getenv("KLUNOK_PREFIX") or prefix

excluded_paths[home('')] = true
cluded_paths[home('src')] = true
history_paths[home('.bash_history')] = true
included_paths[home('.config/qutebrowser/bookmarks')] = true
included_paths[home('.config/REAPER/reaper.ini')] = true
included_paths['/etc/nixos'] = true
project_parents[home('src')] = true
project_roots['/etc/nixos'] = true
