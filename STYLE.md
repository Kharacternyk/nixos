As I care about little code style details much more than I should,
I'll keep a list of absolutist rules here,
so that I can ask an LLM to check whether they hold everywhere.

- No empty lines in Nix code.
- No single-line non-empty lists, even if they contain a single item.
- No single-line non-empty attribute sets, except for module input parameters.
- All attributes are sorted by name.
- No hashes except in flake.lock.
- Dotted attribute set assignments are combined all the way into one nested tree.
- Attribute sets with a single attribute are spelled with dotted paths.
