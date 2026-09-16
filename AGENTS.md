# AGENTS.md

## Pull requests

Every PR description MUST follow `.github/pull_request_template.md` exactly: the
`# Summary`, `## Why`, `## How`, and `## Testing` headings, in that order. Never
write a custom body, never rename or reorder sections, never drop one.

- `# Summary` — one line on what the PR does.
- `## Why` — one or two sentences per bullet on why the change is needed.
- `## How` — how it is implemented.
- `## Testing` — how it was verified. This repo has no test framework: the real
  check is that Neovim still loads clean, e.g. `nvim --headless -c 'qa' 2>&1`
  (non-zero exit or stderr output = failure). Say which commands you actually ran.
