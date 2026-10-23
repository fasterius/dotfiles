# Work

This is a general purpose environment for bioinformatics work.

## Tooling

- **git**: use freely for local operations (status, diff, log, add, commit). Do
  **not** attempt `git push` or `git pull`; the user handles pushes manually.
- **ripgrep** (`rg`) and **fd**: prefer these over `grep -r` and `find` for
  speed and gitignore-aware behaviour.
- **pixi**: you can use this for both bioinformatics-related software, but a lot
  of other software is available as well.
  - `pixi init` if there isn't already a `pixi.toml` in the project. Add the
    `conda-forge` and `bioconda` channels manually afterwards if missing. Add
    `linux-aarch64` (for usage inside the sandbox), `linux-64` (for the `amd64`
    sandbox and CI) as well as `osx-arm64` (for manual user usage outside the
    sandbox).
  - `pixi add <package>` to install software that you want access to, if not
    already installed in the environment. Pixi can install anything available in
    the Conda repositories, not just bioinformatics-related software.
  - **Use `pixi run <cmd>`** to run installed software.
  - Stick to `conda-forge` and `bioconda` whenever possible; if you want to
    install a package from another channel, _always_ ask the user for permission
    first.
  - Older Bioconda versions often lack `linux-aarch64` builds; if a needed
    package or pinned version is unavailable, say so rather than working around
    it, as the user can switch to the `amd64` sandbox.

# Comments

- When writing comments, never include information on why something was changed
  in favour of some previous functionality, that is not useful information for
  the future. Never refer to work done during an agent session, just stick to
  the code at hand.

# Nextflow

- Use Harshil alignment.
- Never edit `*.snap` files, those are only changed when running `nf-test`.

# Writing style

- Use British spelling whenever possible.
- Use 4-space indentation, unless a project's existing files use otherwise.
- For Markdown: use single _underscore_ for italics, double **asterisks** for
  bold; always use italics around _e.g._, _i.e._, _etc._ and similar words.
- Wrap comments, Markdown and other running text the way Vim's `gq` does with
  `textwidth=80`, so that reformatting a paragraph in Vim changes nothing:
  - Lines can be up to _and including_ 80 characters, counting indentation and
    comment leaders.
  - Fill lines greedily: only break when the next word would go past column 80,
    never earlier.
  - Continuation lines of list items line up with the text after the list
    marker.
  - When editing part of a paragraph, re-wrap the whole paragraph.
  - You can go beyond 80 characters for _e.g._ links in Markdown or to write
    proper Harshil alignment in Nextflow.
