function home(string)
    return '/home/nazar/' .. string
end

history_paths[home('.bash_history')] = true
history_paths[home('.Rhistory')] = true
project_roots[home('src/klunok')] = true
