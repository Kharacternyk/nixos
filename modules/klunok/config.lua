prefix = os.getenv("KLUNOK_PREFIX") or prefix
suffix = os.getenv("KLUNOK_SUFFIX") or ""

journal_timestamp_pattern = journal_timestamp_pattern .. suffix

excluded_paths['/home/nazar'] = true
cluded_paths['/home/nazar/src'] = true
project_parents['/home/nazar/src'] = true

history_paths['/home/nazar/.bash_history'] = true

editors["uutils-coreutils"] = true
project_roots['/etc/nixos'] = true
