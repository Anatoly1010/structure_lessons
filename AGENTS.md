# AGENTS.md

These instructions apply to the whole repository.

Read [CLAUDE.md](CLAUDE.md) before working here. It is the detailed reference for the course, source documents, Typst conventions, figures, typography, and known layout issues. Follow its project guidance; keep detailed rules there rather than duplicating them in this file. Current user instructions take precedence over historical migration notes.

## Working approach

- Make the smallest change that fulfills the request. Do not refactor unrelated material or add dependencies without a concrete need.
- Keep communication concise and maintain a short checklist for work with several steps.
- Preserve the Russian course content and established notation. Do not add, omit, or reorganize teaching material without instructions.
- Keep code comments to one short line, and omit obvious comments.
- Preserve existing user changes. Never overwrite one machine's work with another copy without comparing them.

## Repository contents

- `Term1/typst/`: 15 lessons, the shared template, bibliography, compiled PDFs, and `figures/`.
- `Term2/typst/`: 14 lessons, the shared template, bibliography, compiled PDFs, and `fig/`.
- `fonts/`: the static Noto Serif fonts required for reproducible builds.
- `CLAUDE.md`, `AGENTS.md`, `.gitignore`, and `.gitattributes`: repository guidance and configuration.

The two `lecture.typ` templates must stay in sync. Books include the existing lesson files; do not create separate lesson copies for a book.

The root `figures/` archive, original lesson PDFs outside `typst/`, `old/`, videos, archives, helper scripts, local settings, and `.migration/` are deliberately untracked. Preserve local copies and respect the `.gitignore` allowlist. A fresh clone has all figures needed to compile, but does not contain the original source PDFs or editable root figure archive.

## Build and verify

Use Typst 0.15.1 consistently on both machines unless an upgrade is requested. From the repository root:

```powershell
typst compile --font-path fonts --ignore-system-fonts --input book=1 Term1/typst/Lectures_Term1.typ
typst compile --font-path fonts --ignore-system-fonts --input book=1 Term2/typst/Lectures_Term2.typ
```

For a standalone lesson, use the same font flags with its `.typ` path and omit `--input book=1`. PDFs are written beside their sources. Both font flags are required; `--input book=1` is required for books. If Windows locks an output PDF, ask the user to close its viewer.

After changing a lesson, template, or figure, rebuild the affected standalone lessons and books. Inspect the affected PDF pages, including equations, captions, and page breaks; compilation alone does not establish visual correctness. Keep the tracked PDFs current with their sources.

## Figures and source fidelity

Never redraw a figure without the user's permission. Reuse the figures inside the appropriate Typst directory. Consult the local root figure archive when needed; if the master or source PDF is unavailable, ask where it is rather than assuming it does not exist. Apply the detailed SVG and transcription rules in `CLAUDE.md`.

## Git and migration

The remote is `https://github.com/Anatoly1010/structure_lessons.git`. Git replaces the former YandexDisk copying workflow. Do not run the old robocopy sync, force-push over remote history, or delete the YandexDisk copy before the upload and a fresh checkout are verified.

When removing files from the repository, preserve local copies unless the user explicitly asks to delete them from disk. If sandbox restrictions prevent Git writes or network access, report the actual blocker and provide the exact remaining commands for the user's external terminal; do not claim a commit or push succeeded.
