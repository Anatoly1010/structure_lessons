"""Убирает переводы строк внутри <text> в SVG-рисунках лекций.

Inkscape при сохранении раскладывает каждый <tspan> на отдельную строку. По
спецификации SVG такие переводы строк отбрасываются (Inkscape так и рисует), а
resvg внутри Typst превращает каждый в пробел: индексы печатаются как «ν 0», а
подписи с выключкой вправо разъезжаются и наползают на рисунок.

    python fix_svg_text.py Term2/typst/fig/l13_fig9_block.svg
    python fix_svg_text.py "Term2/typst/fig/l13_*.svg"

Запускать после каждой правки рисунка в Inkscape. Пути обязательны: правка
меняет разметку файла, поэтому по всему репозиторию скрипт сам не ходит.
"""
import glob
import os
import re
import sys


def fix_text(block):
    head_end = block.index(">") + 1
    head, inner = block[:head_end], block[head_end:-len("</text>")]
    if "\n" not in inner:
        return block

    def repl(m):
        before, after = m.group(1), m.group(3)
        glue = "" if before.endswith(">") and after.startswith("<") else " "
        return before + glue + after

    prev = None
    while prev != inner:
        prev = inner
        inner = re.sub(r"(>|[^\s>])(\s*\n\s*)(<|[^\s<])", repl, inner)
    return head + inner.strip() + "</text>"


patterns = sys.argv[1:]
if not patterns:
    sys.exit(__doc__)
root = os.path.dirname(os.path.abspath(__file__))
changed = 0
for pattern in patterns:
    for path in sorted(glob.glob(os.path.join(root, pattern))):
        src = open(path, encoding="utf-8").read()
        out = re.sub(r"<text\b.*?</text>", lambda m: fix_text(m.group(0)), src, flags=re.S)
        if out != src:
            open(path, "w", encoding="utf-8", newline="").write(out)
            print(os.path.relpath(path, root))
            changed += 1
print(f"поправлено файлов: {changed}")
