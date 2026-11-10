# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

# Working rules

- Plan in the main session, together with me. Hand grunt work (board searches, repetitive edits, boilerplate, log digging) to subagents on lesser models: Sonnet for searches, triage, and trivial mechanical work, and Opus for writing code. Keep decisions, architecture, and final review in the main session.
- Always look for the simplest solution first, and prefer it. The smallest change that solves the actual problem beats a bigger design, Extend existing patters before inventing new ones. No new dependencies or moving parts without a real reason.
- Show me a checklist while you work (use the todo list tool), keep current, so I can see what you are working on, what is done, and what is next.
- When you spawn a subagent, tell me at that moment: which model it runs on and what it is doing. Report what it came back with when it finishes.
- Never use Haiku.
- Comments: never multi-line. Omit the comment entirely when the code is obvious; otherwise one short line. Explain a fix in the commit message and the review/roadmap docs, not in the source.
- No over-explaining: Deliver the exact output requested. Do not narrate internal steps or show reasoning chains. Do not use programming jargon.
- Strict scope control: Stop when the requested task is complete. Do not expand, refactor unrequested areas, or suggest extra features.

## What this repo is

Lecture notes for a university chemistry course «Строение вещества» (structure of matter), in Russian. Two terms:

- `Term1/` — atomic and molecular structure, 15 lessons. Sources are Google Docs exports (`Lesson_N_Title.pdf`), text is selectable.
- `Term2/` — spectroscopy and magnetic resonance, 14 lessons. Sources are scans of handwritten lectures.

The ongoing work is **refactoring these lessons into Typst**, one lesson at a time, in lesson order. The source PDF is the reference; the Typst file must reproduce it faithfully.

### Google Docs originals

The live masters for Term1 are Google Docs, in this shared folder:

https://drive.google.com/drive/folders/17mJSDbHHqfk7tw49jcHOhPVO_cUstyyw?usp=sharing

WebFetch on the folder returns the **names** of all 15 lessons but not their document IDs (those sit in the page's JavaScript and are stripped in conversion), so use the table below. Build a URL as `https://docs.google.com/document/d/<ID>/edit`; the lesson number was read from each document's «Лекция N» heading.

| № | Topic (first section, as in the doc) | Document ID |
| --- | --- | --- |
| 1 | Оператор углового момента | `1ajFzZ9Qs7q98xQqFIt-2yZnx39iJfBP-zrEwzxzW5bE` |
| 2 | Атом гелия | `177TESeQ_34M2b0IjjfqZiZp44mKLO0NbZdiaStN-rV8` |
| 3 | Термы атомов | `1_9JeX8FlnUxDC7q8Dsa8O0a2iUbgDATDK_fr6v1i3vA` |
| 4 | Классификация термов в пределе jj-связи | `1JRuvK9JIb0R4nDKu7VBSS7lhFYeq-8sfJdCDwnED9RI` |
| 5 | Правила отбора для водородоподобного атома | `1UVqp19rNUOuVdFoVa55SwJTiY-wZhveiPv19fSjDjDA` |
| 6 | Многоэлектронный атом в магнитном поле | `1Z9hNV7LrtxBm9gNg-inRGksr2G1Q-ntPIRD9fBgCqdo` |
| 7 | Приближение Борна-Оппенгеймера | `1oevCM8CxgPtoKqdajdEgSrF3LvH568mPSPyDteUc67o` |
| 8 | Описание двухатомных молекул на языке теории МО ЛКАО | `1fQJPZd-pgZ1EDTtCf0hjsUXCJx5rfgBAwFpWFykbsUo` |
| 9 | Симметрия молекулярных систем. Операции симметрии | `1OtDoGMgi1eiMBc9UNBR5Du6cJk09K-V6_4S3oZtQjBg` |
| 10 | Описание π-сопряжённых систем методом Хюккеля | `1wHwBizefjVEXdFelOzSIzeeMRgao5zPmql78X6g3Vpw` |
| 11 | Специальные хюккелевские системы. Альтернантные системы | `1pxWIuYa9nURs5x8N4IF3CQB6AAD9_3TFFIyC8P76HBY` |
| 12 | Специальные хюккелевские системы. Циклические системы | `1lyLadxviJ1jzupCpPaRfUgCqYdsHR4y8eevajuNWWRg` |
| 13 | Введение гетероатома в π-систему | `1gLUoAo5o8aTQN6Ncq4Or806TaCMdVcUadGKuLSTGRbY` |
| 14 | Направление преимущественного замещения в реакциях | `1WMjpFHj9-LcdLMgXoHQDM4EhoCMEQqnxrfOpTnrzmys` |
| 15 | Непересечение состояний с одинаковой симметрией | `17q0xi-uDACKHQ37teb36rrXvz1HokvlENmRE57uBuMQ` |

The PDFs in `Term1/` are exports and **can be out of date** — the doc may have been edited since. When something in a PDF looks wrong, inconsistent, or like a typo, check the document.

Reading a document without a browser: the docs are link-shared, so the plain-text export is fetchable unauthenticated.

```
https://docs.google.com/document/d/<DOC_ID>/export?format=txt
```

WebFetch it, then WebFetch the `googleusercontent.com` redirect it reports back. Two caveats: WebFetch answers through a small summarizing model, so ask **narrow, literal questions** ("list every heading exactly as written") rather than "return the full text" — a request for verbatim text comes back paraphrased. And the redirect URL is short-lived, so refetch the `/export` URL to get a new one.

### Layout

```
Term1/Lesson_N_Title.pdf        source (Google Docs export)
Term1/typst/lecture.typ         shared template
Term1/typst/Lesson_N_Title.typ  refactored lesson (name matches the source PDF)
Term1/typst/Lectures_Term1.typ  the whole term as one book — cover, preface, contents, 15 lessons, bibliography
Term1/typst/references.bib      course bibliography
Term1/typst/figures/            figures used by Term1 lessons (png, svg)
Term2/Lesson_N_Title.pdf        source (scan of the handwritten lecture)
Term2/typst/lecture.typ         identical copy of the template — keep the two in sync
Term2/typst/Lesson_N_Title.typ  refactored lesson (name matches the source PDF)
Term2/typst/Lectures_Term2.typ  the whole term as one book — cover, preface, contents, 14 lessons, bibliography
Term2/typst/references.bib      course bibliography
Term2/typst/fig/                figures used by Term2 lessons
figures/                        CorelDraw masters (Fig_N.cdr + Fig_N.png), numbered straight through the whole course, both terms
fonts/                          static Noto Serif faces — required for bold, see Build
```

Done so far: Term1 lessons 1–15 (all), bound into the Term1 book; Term2 lessons 1–14 (all), bound into the Term2 book.

### Build

```
cd Term1/typst && typst compile --font-path ../../fonts --ignore-system-fonts Lesson_N_Title.typ
cd Term1/typst && typst compile --font-path ../../fonts --ignore-system-fonts --input book=1 Lectures_Term1.typ
cd Term2/typst && typst compile --font-path ../../fonts --ignore-system-fonts --input book=1 Lectures_Term2.typ
```
Output PDF lands next to the source. The "variable fonts are not currently supported" warning about Noto Serif is expected and harmless.

**`--input book=1` is not optional for the book.** Typst allows only one bibliography per document, so a lesson prints its own «Список литературы» when built alone and skips it inside the book; the flag is what tells it which. Both `Lectures_Term1.typ` and `Lectures_Term2.typ` panic with a reminder if the flag is missing.

**`--font-path` is not optional.** Only the *variable* Noto Serif is installed system-wide, and Typst cannot instance variable weights, so without the flag every `weight: "bold"` silently falls back to the regular face — headings, `lit`, `sub` and `topic` all print at regular weight and nothing warns you. `fonts/` holds static Regular/Bold/Italic/BoldItalic, which Typst can use directly. It lives in the repo (not the system font store) so the mirror on the home machine builds identically.

**`--ignore-system-fonts` keeps the two machines in step.** `▸`, the bullet in the `topic` plaque, is absent from Noto Serif, so it always falls back — and to a *different* font per OS: FreeSerif on Linux (a system font), NewCMMath-Bold on Windows (bundled with Typst). The flag takes the system store out of the search, so both land on the bundled math font. Diagnosed 2026-08-31 by diffing a Linux-built PDF from the mirror against a Windows rebuild of the same source.

**Both machines must run the same Typst version.** 0.15.1 as of 2026-08-31. Versions differ in math layout — 0.14.2 places the vector accent in `arrow(r)` after the subscript, 0.15.1 binds it to the letter — which changes equation heights and shifts every page below by two or three lines. Body text is unaffected: with the same version and the flag above, word coordinates on the two machines agree to 0.01 pt. `winget upgrade Typst.Typst` on Windows.

Close the PDF in the viewer before rebuilding — Windows locks the open file and Typst fails with `os error 32`. Use `typst watch` instead of `compile` while editing.

### The books (`Lectures_Term1.typ`, `Lectures_Term2.typ`)

Each term as one A5 volume — 154 pages for Term1, 161 for Term2. They **include the lesson files unchanged**; the lessons still compile standalone, so never fork a lesson for the book. The two book files are the same skeleton with different covers, subtitles, prefaces and `#include` lists.

Order: cover → титул → предисловие → список сокращений → содержание → лекции → список литературы. Both volumes carry a «Список сокращений» there, a `grid` of the abbreviations used in the text; like предисловие and содержание it is `heading(level: 1, numbering: none, outlined: false)`. Both are laid out the same way: two independent `grid(columns: (auto, 1fr))` halves side by side inside `grid(columns: (1fr, 1fr), align: top)`, with `leading: 0.45em` so a two-line expansion does not tear the column apart. Two independent halves rather than one four-column grid, because a shared grid ties the rows of the halves together and a wrapped line on the left opens a hole on the right. Term1 lists 16 entries (АО, МО, КВ, ЛКАО, ВЗМО, НП, ТФП, …), Term2 50 (Cyrillic plus the method acronyms COSY, NOESY, FRET, TCSPC, …).

- **Cover** is `figures/cover_v2_kran.png` (Term1) or `fig/cover_kran_term2.png` (Term2) on a one-off `#page(margin: 0pt, …)`, full bleed. The title is drawn inside the image, not typeset — so the subtitle on the title page must be copied from the cover, not invented: «Часть 1. Строение атомов и молекул», «Часть 2. Спектроскопические методы».
- **Title page** deliberately does not use `base-style`: the short-word rule eats the forced break before «ПО» in «КУРС ЛЕКЦИЙ \ ПО СТРОЕНИЮ ВЕЩЕСТВА» (the same gotcha as headings, below). It sets the font by hand instead.
- **Front matter is roman** (предисловие iii, содержание iv onward), main matter restarts at 1. The reset must be `pagebreak()` → `set page(numbering: "1")` → `counter(page).update(1)`, **in that order**: update the counter before leaving the page and the last page of the contents becomes page 1.
- **Предисловие and Содержание are `heading(level: 1, numbering: none, outlined: false)`.** `numbering: none` is load-bearing — a numbered level-1 heading counts as a lecture, and «рис. 15.1» silently becomes «рис. 17.1».
- **Contents and PDF bookmarks** (80 in Term1, 86 in Term2) come for free from the lecture title being a level-1 heading; `outline(depth: 2)` lists lectures and their sections.
- **The contents fits two pages, and that is deliberate.** Gaps between outline entries obey `par(leading)`, *not* `par(spacing)` or `block(spacing)` — both of those change nothing at all. `leading: 0.65em` against the 8pt body default is what keeps each Содержание off a third page. Level-2 entries are wrapped in `block(above: 0.7em, it)` as well: without that the `sticky: true` on the lecture title has no following block to attach to, and a «Лекция N» line hangs alone at the foot of the page. `0.7em` was chosen to match the density of the earlier untightened setting.
- **Figure numbers are «лекция.рисунок»** in the book and plain «рисунок» standalone. The `#set figure(numbering: …)` that does it lives in the book file only; `lecture()` resets the figure counter at each lecture.
- **Bibliography** is `style: "ieee"` (square brackets, matching how the sources were written by hand) with `full: true`, so the кафедра textbooks print even though nothing cites them. Typst 0.14 has no GOST style built in.
- **Adding a lesson**: one `#include` line in lesson order. Check first that its figure labels are `<lN_figM>`, or the build fails on an ambiguous reference.
- **A book need not be complete.** A forward `lref` to a lesson that is not in the build prints as plain text and turns into a hyperlink by itself once that lesson is included.
- **A lesson paginates differently in the book than standalone**, because every figure number gains the lecture prefix: «рис. 6» in the text becomes «рис. 1.6», and «Рис. 6.» in the caption becomes «Рис. 1.6.». Two extra characters are enough to turn a two-line paragraph into three, and if that paragraph was the last thing on the page every following page break shifts, which can open holes of 150–200 pt further down. Judge the layout from **both** PDFs. The cure is to give the page a little slack — a few per cent off a figure on the same page is usually enough to stop the cascade, and it leaves the standalone pagination alone.

### Git repository and YandexDisk migration

The working repository is `D:\Melnikov\12_Teaching\05_Matter\04_Lessons`, with remote `https://github.com/Anatoly1010/structure_lessons.git`. Git replaces the one-way YandexDisk sync. Do not run the old robocopy sync.

Migration started on 2026-11-10. The initial local commit is `08c2058` and includes the rebuilt PDFs. GitHub upload and a fresh checkout have not yet been verified because this session cannot reach GitHub. Inspect the remote's existing history before publishing; never force-push over it.

- The SHA-256 comparison found 551 identical files, one differing Lesson 10 source, and one additional Lesson 9 draft in YandexDisk.
- Keep the current Lesson 10: its newer wording is «на наборы-орбиты», versus «на такие наборы» in the mirror. The older file is preserved locally in `.migration/yandex-originals/` and excluded from Git.
- The author confirmed that the main Lesson 9 is correct. The extra `Lesson_9_Group_Theory_for_Chemists (2).typ` draft adds no material to merge and inconsistently switches class-size notation from `g(c)` to `n_c`. Its unchanged copy is archived in `.migration/yandex-originals/` and excluded from Git; the book continues to include the main lesson.
- `.migration/comparison.json` records the original inventories, timestamps, SHA-256 hashes, and differences. `.migration/` is local and ignored by Git.
- Track only `CLAUDE.md`, `.gitignore`, `.gitattributes`, the figures and fonts directories, and each term's `typst/` sources, bibliography, compiled lesson/book PDFs, and figure directories. `.gitignore` allows only those paths. Original PDF exports and scans outside `typst/`, archives, old handouts, extra reference documents, helper scripts, collages, videos, local settings, installers, and migration backups remain local and must not be added to Git. A fresh clone contains the compiled PDFs, but not the original source PDFs referenced elsewhere in this guide.
- Keep `C:\Users\User\YandexDisk\05_Matter\04_Lessons` until the first push and a fresh checkout have been verified. No files in that mirror were changed or removed during preparation.

After migration, commit and push changes from the machine where they were made, and pull before editing on the other machine. Use `git pull --ff-only` with a clean working tree; reconcile any divergent changes without overwriting either copy.

### Lesson file conventions

- Preamble is always `#import "lecture.typ": *` then `#show: lecture.with(title: "Лекция N. …", start-section: 1)`. A lesson that cites a source adds `bib: "references.bib"`.
- The lecture title is a **level-1 heading**, and the template shifts the lesson's own headings down one level, so `=` is a section and `==` a subsection exactly as before. That is what puts lectures into the book's contents and the PDF bookmarks. Never write `=` for the lecture title itself.
- The template (`lecture.typ`) provides `lit`, `sub`, `topic`, `item`, `subitem`, `ctable`, `earrow`, `epair`, `larrow`, `fref`, `lref`, `ttr`, and imports cetz. It sets A5, Noto Serif 8pt, Russian typography rules (non-breaking short words, non-breaking hyphens), numbered `=`/`==` headings, figure spacing, and looser math spacing than Typst's defaults — `mat` 0.35em/0.9em, `vec` 0.35em, `cases` 0.6em, because the stock 0.2em row gaps make big determinants and equation systems look glued together. Do not re-set these per lesson.
- `ttr` puts a figure's caption to the **right** of the figure instead of under it — `#ttr(width: 40%)[#figure(image("…", width: 100%), caption: […]) <figN>]`. The caption is left-aligned and justified. Use it only when the image is ≤ ~60% of text width (a narrower caption column shreds the text into hyphenated fragments) and the figure is not very flat (aspect ratio ≲ 2.5, or the caption ends up taller than the picture). It works inside `#place(…, float: true, …)` too. Its `above`/`below` (1.4em/1.7em by default) are parameters: pass a smaller `below` when a tall picture leaves too much air before the next paragraph (`#ttr(width: 34%, below: 0.9em)[…]` in Lesson 13's figure 11).
- **The structure is one ladder, and it is the same in both terms**: `= раздел` (auto-numbered) → `== подраздел` → `#sub[А. …]` lettered part → `#item[#lit[1)] …]` enumeration → `#item[#lit[а)] …]` nested enumeration → `#item[#lit[•] …]` unordered list, or `#subitem[#lit[•] …]` when that list sits inside a numbered item (the same paragraph with a 1em indent; both helpers live in `lecture.typ`). The helper is **not** called `bullet`: that name is the math symbol • and a `#let bullet` in the template shadows it, so `$"А"^bullet$` silently prints the word «bullet» instead of the dot. Digits are always the outer level and letters the inner one — never the other way round. A `#sub` carries a letter only where the section holds two or more of them; a lone subheading goes without one. A lettered run in running text («А. …», «Б. …») is a heading when its items span paragraphs with formulas and figures — then it becomes `#sub[А. …]` — and an enumeration otherwise, then it becomes `1)`. A mention of an item is plain text («случай 1)», «пункт 4)»), never `#lit`. Both terms were swept to this ladder in 2026-08.
- **Every enumeration item is `#item[…]` — a paragraph with no first-line indent.** `1)`, `2)`, `а)`, `б)`, `А.`, `Б.` all start flush left, in both terms, so a list reads the same whether it follows prose (which would otherwise indent it) or a figure (which would not). The helper is `#let item(body) = par(first-line-indent: 0pt, body)` in `lecture.typ`; the Term2 lessons still carry an identical local copy, which shadows it harmlessly. An item that carries a display equation or a bulleted list wraps only its own text — the equation and everything after it stay outside the `#item[…]`, since `par` cannot hold block content. Do not patch a single item with `#h(1.3em)`, `#par(first-line-indent: …)` or a `pad(left: 1.3em, …)` around the grid that carries a numbered formula; those were swept out in 2026-08. A normal paragraph that merely opens with a bold phrase (`#lit[Теорема Вигнера—Эккарта.]`) is not an item and keeps its red line.
- `sub` (letter subheading А./Б./В. inside a section) lives in the template. It is `sticky: true`, so a subheading never ends up alone at the bottom of a page. Lesson 11 shadows it with a local copy that sets `hyphenate: false` — its subheadings are long and «аль-тернантные» in the middle looks bad.
- Other per-lesson helpers are defined at the top of the lesson file, not in the template: `ket`, `bra`, `bk`, `mel` (Dirac notation via `lr`), plus whatever that lesson needs. Copy them from the previous lesson.
- `topic` (the gray plaque) is for **additional material only** — an aside the reader can skip. Term2 uses it for extra derivations and character rows; in Term1 it marks the Wigner-symbol asides in lessons 1, 3 and 5. Do not reach for it as a general subheading; that is what `sub` is for.
- Sections use `=`, lettered parts inside a section use `#sub[А. …]`.
- A mention of a section or of a hand-numbered table is a hyperlink too, inside the same lesson: label the target (`= Правила отбора … <l9_sec7>`, `#sub[Б. …] <l1_subB>`, `#tcap(2)[…] <l9_tab2>`) and write `#link(<l9_sec7>)[раздела 7]`. The number stays hand-written, matching how those numbers are written in the first place. A table that is a real `#figure(kind: table)` is referred to with `#ref(<l15_tab1>, supplement: [таблице])` instead, so the number is automatic.
- **A table caption goes above the table, a figure caption below.** The template does it: `show figure.where(kind: table): set figure.caption(position: top)`. `tcap` writes its «Таблица N. …» line above by hand and matches. Both copies of `lecture.typ` carry the rule — keep them in sync.
- **The gap between a table caption and the table is 1.5em**, the same in every lesson: `tcap` carries `below: 1.5em` and the template gives a real `#figure(kind: table)` `gap: 1.5em`. The blocks that hold the tables themselves (`ctable`, `gtab`, `chartab`, hand-rolled `#block`) all set `above` at or below that, and Typst collapses the pair to the larger value — so the caption distance is `tcap`'s to set.
- **A full-width caption is centred — tables and figures alike.** A `#figure` caption is centred by Typst already; `tcap` has to say so itself, so every per-lesson copy wraps its text in `align(center, …)`. Both terms follow the rule; a left-aligned or justified table caption is a slip, not a variant.
- A bare `#table(…)` that is not a `#figure` still needs the surrounding air a `ctable` gets: wrap it in `#block(width: 100%, above: 1.5em, below: 1.3em, align(center, …))`. Without `width: 100%` the block shrinks to the table and `align(center, …)` stops centring anything.
- A mention of another lesson is a hyperlink: `#lref(<l1_lecture>)[лекции 1]`. The target is `#metadata(none) <lN_lecture>` in the preamble of the lesson being pointed at — add it there if it is missing. Outside the book there is nothing to link to, so `lref` prints the words as plain text; it does the same inside a book that does not include the lesson being pointed at, instead of failing the build.
- Sources are cited, never written out by hand: `@atkins2010[p. 95]` → «[1, p. 95]», `@minkin1997[стр. 68]` → «[4, стр. 68]», `@parr1989` with no page. Two in a row (`@a[…] @b[…]`) print as two adjacent brackets. A leading «см.» goes **before** the citation, in running text. Keys live in `references.bib`.
- Russian text: `ё`, em dash `—`, «ёлочки», decimal comma written as `0","8` inside math.
- **No «т.к.» and «т.е.»** — anywhere, including inside `$…$`. Write the words out and let the sentence flow: «т.к.» → «поскольку» (or «так как», or a colon), «т.е.» → «то есть». Both terms were swept clean of them in 2026-08; keep them that way. If the expansion puts two «поскольку» in one sentence, rephrase the second half instead. «и т.д.» and «и т.п.» are fine.
- **No semicolons in running prose.** A «;» inside a sentence is not used in these notes: split the sentence in two, or replace the «;» with a comma, a dash or a colon. The exception is where the semicolon is a separator rather than punctuation — between items of an `#item[…;]` enumeration, and inside math (`$J = 0, 1, 2, dots; quad K = …$`).
- **A display equation is part of the sentence, so it ends with the punctuation the sentence needs.** A comma when «где» or the rest of the sentence follows, a full stop when the sentence ends, «;» between the equations of one enumeration and a full stop after the last. The mark goes inside `$…$`, tight against the last symbol: `$ V(x) = 1/2 K_f x^2, $`. Four cases stay bare: the equation is a member of a sentence that continues in lower case («уравнение $…$ решается точно:»); it is the first half of a derivation split in two (ends in `=`, the continuation opens with `#hide(…)`); the mark is already inside the math text (`"терм;"`, `" м.д."`); **the equation ends with a `cases(…)` block** — a system of equations or a piecewise definition takes no mark at all next to the big brace, neither after the closing brace nor inside its last row. If the rows of such a system carry «;» separators, every row carries one, the last included. Both terms were swept to this rule in 2026-08 — 800 equations, 16 of them deliberately bare — and to the `cases` exception in 2026-08 (27 formulas).
- Numbered equations start at **(1)**, never (0) — both `#numeq(n)` and hand-written `quad (n)`.
- An arrow with a caption under it is `larrow("подпись")`, not `underbrace(->, "подпись")`.
- **A reversible reaction gets two straight opposing arrows, stretched, with the rate constants above and below**: `attach(stretch(arrows.rl, size: #2em), t: k, b: k)` (one label only if the reaction is one-sided in the source). Not the harpoons `⇌` and not a bare `<-->`: at 8pt the stock glyph is too small to read and its labels collide. Drawn versions in figures match — two straight arrows, `k` above and below.
- **A radical dot is `^bullet`**, never `dot.c` and never the `dot()` accent: both are invisible at 8pt. It goes after the formula (`"А"^bullet`, `"C"_6"H"_6^(- bullet)`) or before the radical centre when the atom carrying the electron matters (`""^bullet"CH"_2 - "CH"_3`). In an SVG figure it is a filled `circle` of r ≈ 2 at 14px type, not a text `•`.
- **No prose comments inside display equations.** Both terms were swept clean of this in 2026-08; keep them that way. A display equation carries mathematics only. In particular:
  - Never wedge an explanation into a formula as `= \/ "текст" \/ =` (the old `inlnote` device, now deleted), and never park prose in a grid cell beside an equation — that variant hides from a search for `$…$`.
  - **«где» belongs in running text**, on the line right after the equation, never inside `$…$`: `$ V(x) = 1/2 K_f x^2, $` then `где $K_f = ((d^2 V) \/ (d x^2))_0$.` Several symbols go in one sentence: `где $X$ — описание, $Y$ — описание.`
  - Symbol glosses (`X quad "— кулоновский интеграл"`), step words («далее», «откуда», «сначала», «или сокращённо») and row labels («по $A''_2$:» → «$A''_2$:») go the same way.
  - A `cases` block that is really a «где» list of index ranges gets dissolved into a sentence; a `cases` that is a genuine piecewise definition stays.
  - Still fine, because they attach to a specific object rather than float in the formula: `larrow` captions, `underbrace`/`overbrace` labels, labels under sum limits, genuine `cases` conditions («если …», «иначе», «в остальных случаях»), one-word connectives («или», «то есть», «при», «то»), and inline substitutions such as `\/ Z = 2 \/`.
- **A chemical formula is set upright, as a quoted run inside math**: `$"CH"_3$`, `$"H"_2"O"$`, `$["Fe"("CN")_6]^(4-)$`, `$"C"_6"H"_6$`, an isotope as `$""^13"CO"$` or `$attach("C", tl: 13)$`. Never as bare math letters (`$C H_3$` prints italic *C H* with a gap between them, and italic *C*, *N*, *S*, *F*, *I*, *K*, *B* read as the physical quantities of the same name) and never as `upright(F e)` (which keeps the gap). The rule covers element symbols wherever they appear, subscripts included: `alpha_"C"`, `delta_"N"`, `xi_("CH"_3)`, `J_("CH"_3)`, `I("H")`. Multi-letter non-chemical abbreviations follow the same logic — `$V_("CF")$`, `$"GS"$`, `$E_"HF"$`. Both terms were swept to this in 2026-08. Term symbols (`""^1 A_(1g)`, `#term(…)`, `#mt(…)`) are not chemistry and keep their own notation. The same split holds inside a figure: an SVG label that is a formula, an atom or a state abbreviation (`N₁`, `O`, `Li₂`, `GS`) is upright, while quantities and orbital labels (`B`, `J`, `R_eq`, `2p`, `1σ_g`) stay `font-style:italic`. A reaction-mechanism symbol is upright and carries no comma: `$"S"_"N""Ar"$`, `$"S"_"E""Ar"$`.
- Greek-letter attributes take a hyphen: `$sigma$-поляризация`, `$pi$-линии`.
- Titles and headings should not leave a single word hanging on the last line — glue it with `\u{00A0}` in the title string, or force the break with `\` in the heading.
- **A `\` in a lecture title breaks the line in the contents only.** The level-1 heading rule and the running head both swallow linebreaks (`show linebreak: it => [ ]`), so the title on the lecture page and in the колонтитул still wraps by itself. Lesson 10's title uses this to split the contents entry after «Хюккеля.». A `\` in a `=` section heading, by contrast, breaks the line everywhere — contents included, so use it only where the entry is too long for one contents line anyway (Term1 lesson 13 section 4, Term2 lesson 9 section 1).
- Do not leave a lead-in line («…имеет вид:») alone at the bottom of a page: wrap it in `#block(sticky: true)[…]`. For a block equation add `width: 100%`, otherwise it loses its centring.

### Fidelity rules

- Transcribe the source; do not add, drop, or reorganize content.
- Silently fix obvious source typos, and tell me afterwards. Example: Lesson 4's Google Doc numbers its sections 1, 2, 4 — verified against the live document, there is no section 3 and no missing content, so the Typst file numbers them 1, 2, 3.
- Verify by reading the compiled PDF pages, not by trusting the source compiled.

### Figures

- **Never redraw a figure without asking me first.** The masters in `figures/` cover both terms and their `Fig_N` numbering has nothing to do with the lesson number, so a lesson's figures are easy to miss. Look through `figures/Fig_*.png` for the drawing, and if you cannot find it, ask me where it is — do not assume it is missing and start drawing.
- Prefer the existing raster master from `figures/`: copy `Fig_N.png` into the lesson's figure directory under the repo name (`lN_figM_slug.png`), do not reference it across directories.
- Some figures are borrowed renderings with no master (shaded 3D solids, textbook grids). Those are best pulled straight out of the source PDF: `pdfimages -f <page> -l <page> -png <source>.pdf <prefix>` recovers the embedded rasters at their native size. `pdftoppm` and Python with PIL are also available for cropping and cleanup.
- **New figures go in SVG, not cetz** — I edit them in Inkscape, so a standalone `.svg` I can open beats a canvas buried in the `.typ`. Only after I confirm there is no master and extraction is not appropriate, redraw it as a hand-editable **SVG** in the lesson's figure directory — plain SVG, Noto Serif, Russian labels, one-line `<!-- -->` comments per part. `Term1/typst/figures/l4_fig1_correlation.svg` and `Term2/typst/fig/l4_anisotropy_setup.svg` are the models.
- **After editing a figure in Inkscape, normalize SVG text whitespace.** If the local, untracked `fix_svg_text.py` helper is present, run `python fix_svg_text.py <путь до .svg>` from the repo root; it is not included in a fresh clone. Inkscape pretty-prints every `<tspan>` onto its own line; the SVG spec says those newlines are dropped and Inkscape draws them dropped, but resvg inside Typst turns each into a space — subscripts print as «ν 0» and a right-anchored label grows and slides left into the drawing. Collapse that whitespace only within SVG text: between two tags → nothing, next to characters → one space. Apply this only to the edited file. A figure is judged from the compiled PDF, never from Inkscape's canvas.
- **Never put `→` (U+2192) or `−` (U+2212) into SVG text** — the static Noto Serif faces in `fonts/` have neither, and resvg falls back for the **whole `<text>` element**, not just the missing glyph: the entire label prints in some system font with wrong letterforms and spacing. It is silent, and easy to miss because Inkscape shows it correctly. Use `–` (U+2013) for a minus, which is present and looks right, and draw an arrow as a path (line + filled triangle) between two `<text>` runs — `l6_fig3_mirror_T_R.svg` is the model. In Typst markup neither is a problem: `$-1$` and `$->$` are set from the math font. The system's own Noto Serif does have `−`, but hundreds of its advance widths differ from the repo copies, so swapping `fonts/` would re-paginate the whole course.
- Include with `#figure(image("figures/name.svg", width: …%), caption: [… .]) <lN_figM>` and refer to it in the text with `#fref(<lN_figM>)` → «рис. M» (a hyperlink), or `#fref(<lN_figM>, word: [рисунке])` → «рисунке M». Never write the number by hand.
- **Arrow tips must be filled.** In cetz they are unfilled by default and print as a hollow outline; write `marks` (a template helper) as the first line of every canvas, right after `import cetz.draw: *`, and the whole canvas gets filled tips. Keep cetz's own `>` shape — do not switch it to `stealth`. In an SVG the tip is Inkscape's Arrow2 at `scale(0.6)`, wired to the markers `ah` (end) and `ahs` (start); copy them from `Term2/typst/fig/l4_fig6_unpolarized.svg`.
- **Figure and table labels carry the lesson number**: `<l7_fig2>`, `<l15_tab1>`. A bare `<fig2>` collides with every other lesson once they are bound into one book, and Typst refuses to resolve the reference. The printed number stays per-lesson: «рис. 2» alone, «рис. 7.2» in the book.
- For a floating figure the label goes on the figure, inside the `place`: `#place(top + center, float: true, [#figure(…) <figN>])`.

### Typst gotchas hit in this repo

- Primes go **before** the subscript: `Delta'_i`, `r'_(i j)`. Writing `Delta_i'` puts the prime inside the subscript.
- Do not pass bare fractions into a `#let` helper — `1/2` is evaluated as code and prints `0.5`. Pass math content: `#helper(($1/2$, $3/2$))`.
- The template auto-shrinks wide block equations via `layout`, which collapses `#h(1fr)`. For a numbered equation use a grid helper (see `numeq` in Lesson 4), not `h(1fr)` inside the equation.
- Wide or tall tables must be wrapped in `block(breakable: false, …)` or they split across pages.
- A block equation whose rows all start with `&` is left-aligned, not centred; a short first line then looks wrong under a long second one. Drop the `&` to centre each row.
- Anything `#`-escaped in markup or math — `#box(…)`, `#mt(…)` — immediately followed by `;` swallows the semicolon (it is read as a code terminator). Put the punctuation inside (`#box[$m_l = 0$;]`) or write it as math text (`#mt(…) ";"`).
- `bar(x)` is the **vertical bar** symbol, not an accent. The overline used for momentum addition (`3̄ + 1̄`) is `overline(x)`.
- Short inline formulas that must not break across lines go in `#box(…)`; `~` is a non-breaking space in markup.
- The template boxes whole double surnames (`Хартри—Фока`) so the em dash never starts a line. Box the *whole* compound, not the three characters around the dash — Typst will happily break straight after a narrow box.
- A forced line break in a heading (`= Первая часть \ вторая часть`) is **silently destroyed** if the word right after it is 1–2 Cyrillic letters: the template's short-word rule `show regex("\s([А-Яа-яЁё]{1,2})\s")` matches across the break and replaces the whole span, break included. `#linebreak()` behaves the same, so it is not a markup-syntax problem. Move the break so a longer word follows it.
- Bold needs `--font-path ../../fonts` on the command line (see Build). Without it bold renders as regular, with no warning — so never judge a heading, `lit` or `sub` from a PDF built without the flag.
- A multi-line label under a sum or over a brace (`объед-мые / центры`) must be built as a one-column `grid`, not as `\` inside a fixed-width `#box`: under `attach` the forced break does not take and the text overflows the box on one line. Lesson 13 defines a `sidenote(..lines)` helper for this.
- `attach(sum, b: …)` sets the label as a lower *index* (to the right) instead of a limit under the Σ when the sum sits inside `mat()`. Wrap the base: `attach(limits(sum), b: …)`.
- `#place(…, float: true, …)` on a figure is not a safe way to fill a short page: when the surrounding text later shrinks, the float can jump *backwards* to an earlier page and land ahead of the text that introduces it. Prefer a plain figure and fix the gap another way.
- Two consecutive block equations can be split across a page break, stranding one alone. If they belong together, make them a single equation with `\` — a block equation is unbreakable.
- **A block equation is unbreakable, so a long derivation that will not fit leaves a hole at the foot of the page.** To let part of it run over, cut it into two block equations at a row that ends in `=`, and start the second one with a phantom of the left-hand side — `$ #hide($arrow(mu)_J$) & = … $` — so the continuation keeps the same indent up to the `=`. `hide` is not available bare in math, hence the `#hide($…$)` form. Lesson 5's $mu_J$ derivation is the model.
- **`it.caption` inside a grid cell shrinks the paragraph to its natural width.** In `ttr` the caption column reaches the right margin, but the `figure.caption` element laid inside it sets its own measure, so the justified lines stopped 5–15 pt short — by a different amount for every figure. Wrapping it in a `block(width: …)`, an `align`, or fixing the grid columns changes nothing. The cure is to compose the caption by hand from `it.caption.supplement`, `it.caption.counter.display(it.caption.numbering)`, `it.caption.separator` and `it.caption.body` (that is what `ttr` does now) — the automatic number, «лекция.рисунок» in the book included, is preserved. It cost no repagination: all 29 lessons and both books kept their page counts and every caption its line breaks.
- **Inline `$…$` does not grow the line, a markup `box` does.** Typst gives an inline equation a frame sized from the font metrics, so tall math (`mat`, `vec`) simply sticks out of it and the leading stays put; a `box` reports its true height and pushes the neighbouring lines apart. To stop a stroked box from spreading the leading, wrap it in an inline equation — `$#obox($arrow.t arrow.b$)$` in lesson 3. `#box($mat(…)$)` does *not* work the other way round: the box inherits the equation's small frame.
