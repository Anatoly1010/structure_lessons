// ============================================================
//  Общий шаблон оформления лекций по строению вещества (Typst).
//  Использование в файле лекции:
//
//    #import "lecture.typ": *
//    #show: lecture.with(
//      title: "Лекция N. Заголовок",
//      start-section: N,        // номер первого раздела (продолжение нумерации)
//    )
//    = Первый раздел
//    ...
//
//  Тот же файл лекции подключается без изменений в сборник (см. книгу курса):
//  заголовок лекции — это заголовок первого уровня, а «=» внутри лекции
//  сдвигается на второй уровень, поэтому нумерация разделов та же, что и
//  при отдельной сборке, а лекции попадают в оглавление и в закладки PDF.
//  Книге доступны base-style, page-cfg и running-head.
//
//  Доступные помощники: cetz, ctable, topic, lit, marks, earrow, larrow, fref, lref.
// ============================================================

#import "@preview/cetz:0.3.4"

// Собирается ли лекция в составе сборника. Typst разрешает лишь один
// список литературы на документ, поэтому в сборнике лекция свой не печатает.
//   typst compile --font-path ../../fonts --input book=1 Lectures_Term1.typ
#let in-book = "book" in sys.inputs

// --- Помощники, доступные в тексте лекции ---

// Буквенный шаг (а), б), …) — полужирная врезка в начале абзаца.
#let lit(l) = text(weight: "bold", l)

// Пункт перечисления — абзац без красной строки.
#let item(body) = par(first-line-indent: 0pt, body)

// Вложенный маркированный пункт — тот же абзац с отступом слева.
#let subitem(body) = par(first-line-indent: 0pt, h(1em) + body)

// Длинная стрелка с подписью снизу (без фигурной скобки).
#let larrow(body, size: 3em) = $attach(stretch(arrow.r, size: #size), b: #text(size: 6.5pt, body))$

// Тангенс в русской записи: tg вместо tan.
#let tg = math.op("tg")

// Гиперссылка на рисунок: fref(<f1>) → «рис. 1», fref(<f1>, word: [рисунке]) → «рисунке 1».
#let fref(l, word: [рис.]) = ref(l, supplement: word)

// Ссылка на другую лекцию: #lref(<l7_lecture>)[лекцию 7]. Цель — метка
// #metadata(none) <lN_lecture> в начале нужной лекции. При отдельной сборке
// цели в документе нет, поэтому печатается обычный текст без ссылки. То же
// самое в сборнике, куда нужная лекция ещё не включена.
#let lref(target, body) = if in-book {
  context if query(target).len() > 0 { link(target, body) } else { body }
} else { body }

// Подпись справа от рисунка, а не под ним (для узких и высоких рисунков).
// #ttr(width: 40%)[#figure(image("…", width: 100%), caption: […]) <figN>]
// Ширина рисунка не больше ~60%: иначе колонка подписи слишком узкая для выключки.
#let ttr(width: 42%, gutter: 14pt, above: 1.4em, below: 1.7em, body) = {
  show figure: it => block(breakable: false, above: above, below: below, grid(
    columns: (width, 1fr),
    column-gutter: gutter,
    align: (center + horizon, left + horizon),
    it.body,
    align(left, {
      set par(justify: true, first-line-indent: 0pt)
      text(size: 7.5pt)[#it.caption.supplement #context it.caption.counter.display(it.caption.numbering)#it.caption.separator#it.caption.body]
    }),
  ))
  body
}

// Лёгкий буквенный подзаголовок (А., Б., В., …) внутри раздела.
// sticky: подзаголовок никогда не остаётся один внизу страницы.
#let sub(t) = block(above: 1.8em, below: 0.9em, sticky: true, text(weight: "bold", size: 8.5pt)[#t])

// Тематическая вставка внутри раздела (без номера) — выделенная серая плашка.
// Только для дополнительного материала, который читатель может пропустить.
#let topic(body) = block(
  above: 1.9em, below: 0.8em,
  width: 100%,
  fill: luma(92%),
  inset: (x: 8pt, y: 5pt),
  sticky: true,
)[
  #set par(justify: false, first-line-indent: 0pt)
  #text(weight: "bold", size: 9.5pt)[▸ #body]
]

// Чистая таблица (booktabs): только верхняя, подзаголовочная и нижняя линии.
// ctable(<число столбцов>, <ячейки…>) — первая строка трактуется как шапка.
#let ctable(cols, ..cells) = {
  let data = cells.pos()
  let nrows = int(data.len() / cols)
  block(width: 100%, breakable: false, above: 1.5em, below: 1.3em, align(center, table(
    columns: cols,
    stroke: (x, y) => (
      top: if y == 0 { 0.8pt } else if y == 1 { 0.5pt } else { 0pt },
      bottom: if y == nrows - 1 { 0.8pt } else { 0pt },
    ),
    ..data,
  )))
}

// Наконечники стрелок в рисунках cetz: залитые (по умолчанию cetz рисует контур).
// Ставится первой строкой в каждой канве, сразу после import cetz.draw: *.
#let marks = {
  import cetz.draw: *
  set-style(mark: (fill: black))
}

// Электрон ↑ на уровне: визуально центрирован на линии. Стрелка чуть приподнята
// (хвост у одиночной стрелки иначе свисает ниже линии и электрон кажется низким).
#let earrow(p) = {
  import cetz.draw: *
  line((p.at(0), p.at(1) - 0.13), (p.at(0), p.at(1) + 0.21), mark: (end: ">", scale: 0.5), stroke: 0.7pt)
}
// Пара электронов ↑↓, центрированная на уровне (x — центр, y — уровень).
#let epair(x, y) = {
  import cetz.draw: *
  line((x - 0.07, y - 0.18), (x - 0.07, y + 0.18), mark: (end: ">", scale: 0.5), stroke: 0.7pt)
  line((x + 0.07, y + 0.18), (x + 0.07, y - 0.18), mark: (end: ">", scale: 0.5), stroke: 0.7pt)
}

// --- Сам шаблон ---

// Колонтитул: название текущей лекции. На странице, с которой лекция
// начинается, колонтитула нет (там уже стоит крупный заголовок).
#let running-head = context {
  let p = here().page()
  let ch = query(heading.where(level: 1))
  let before = ch.filter(h => h.location().page() < p)
  if before.len() > 0 and not ch.any(h => h.location().page() == p) {
    set text(size: 7pt, fill: luma(45%), style: "italic", hyphenate: false)
    // Принудительный перенос в названии лекции не должен ломать колонтитул.
    show linebreak: it => [ ]
    before.last().body
    v(-0.5em)
    line(length: 100%, stroke: 0.4pt + luma(70%))
  }
}

#let page-cfg = (
  paper: "a5",
  margin: (x: 1.3cm, top: 1.7cm, bottom: 1.4cm),
  numbering: "1",
  header: running-head,
)

// Оформление текста, формул и заголовков. Книга применяет его к своим
// страницам (предисловие, оглавление, список литературы) отдельным вызовом.
#let base-style(body) = {
  set text(font: "Noto Serif", lang: "ru", size: 8pt)
  // Красная строка только у абзацев, идущих за другим абзацем (не после формул/заголовков).
  set par(justify: true, leading: 0.85em, spacing: 0.75em, first-line-indent: (amount: 1.3em, all: false))

  // Короткие слова (1–2 буквы: в, на, и, к, с, их …) не оставляем в конце строки —
  // приклеиваем к следующему неразрывным пробелом (надёжно через \s, без \b).
  show regex("\s([А-Яа-яЁё]{1,2})\s"): it => " " + it.text.trim() + "\u{00A0}"
  // То же для короткого слова в начале текстового фрагмента (например, «и» сразу после формулы).
  show regex("^([А-Яа-яЁё]{1,2})\s"): it => it.text.trim() + "\u{00A0}"
  // Сокращения «т.д./т.п.» и «см./рис./табл./стр./напр.» — неразрывно с продолжением.
  show regex("\s([тТ]\.[а-яё]\.)\s"): it => " " + it.text.trim() + "\u{00A0}"
  show regex("\s(см|рис|табл|стр|напр)\.\s"): it => " " + it.text.trim() + "\u{00A0}"
  // Тире внутри двойной фамилии (Хартри—Фока) не должно переноситься на новую строку.
  show regex("\p{L}+—\p{L}+"): it => box(it.text)
  // Дефис перед буквой делаем неразрывным (d-металл, π-орбиталь, Танабе-Сугано, dd-переходы …).
  // Только перед буквой (не перед цифрой) — чтобы не задеть координаты в рисунках.
  show regex("-[A-Za-zА-Яа-яЁё]"): it => it.text.replace("-", "\u{2011}")

  show math.equation.where(block: true): set block(spacing: 0.95em)
  // Широкие блочные формулы автоматически ужимаются по ширине строки (не разбивая их).
  show math.equation.where(block: true): it => layout(bounds => {
    let w = measure(it).width
    if w > bounds.width {
      box(scale(it, x: bounds.width / w * 100%, y: bounds.width / w * 100%, reflow: true))
    } else { it }
  })

  set table(align: center + horizon, inset: (x: 5pt, y: 4pt))

  // Штатные отбивки в матрицах, векторах и системах слишком тесные
  // (row-gap 0.2em, column-gap 0.5em): большие определители выглядят слипшимися.
  set math.mat(row-gap: 0.35em, column-gap: 0.9em)
  set math.vec(gap: 0.35em)
  set math.cases(gap: 0.6em)

  // Первый уровень — название лекции (без номера), второй — разделы «1.»,
  // третий — подразделы «1.1». Номер лекции в номер раздела не входит.
  set heading(numbering: (..n) => {
    let p = n.pos()
    if p.len() == 1 { none } else if p.len() == 2 { numbering("1.", p.at(1)) } else {
      numbering("1.1", p.at(1), p.at(2))
    }
  })
  // Название лекции: всегда с новой страницы. Выключка отключена — у центрованного
  // заголовка она растягивает первую строку.
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    block(below: 1.1em)[
      #set par(justify: false)
      // Перенос в названии лекции задаёт разбиение строки в оглавлении,
      // а на самой странице заголовок переносится сам.
      #show linebreak: it => [ ]
      #align(center, text(size: 11pt, weight: "bold", hyphenate: false)[#it.body])
      #v(-0.3em)
      #line(length: 100%, stroke: 1pt)
    ]
  }
  show heading.where(level: 2): it => block(above: 1.4em, below: 0.7em, {
    set text(size: 10.5pt, weight: "bold", hyphenate: false)
    it
    v(-0.15em)
    line(length: 100%, stroke: 0.7pt)
  })
  show heading.where(level: 3): it => block(above: 1.9em, below: 0.6em, {
    set text(size: 9.5pt, weight: "bold", hyphenate: false)
    it
    v(-0.2em)
    line(length: 100%, stroke: 0.4pt + luma(65%))
  })

  // Больше воздуха вокруг рисунков (в т.ч. после подписи); подпись помельче.
  show figure: it => block(breakable: false, above: 1.4em, below: 1.7em, it)
  show figure.caption: set text(size: 7.5pt)
  // Подпись таблицы — сверху, рисунка — снизу.
  show figure.where(kind: table): set figure.caption(position: top)
  // Зазор под подписью таблицы — как у tcap + ctable (умолчание Typst вдвое теснее).
  show figure.where(kind: table): set figure(gap: 1.5em)

  body
}

#let lecture(title: "", start-section: 1, bib: none, body) = {
  set page(..page-cfg)
  base-style[
    #heading(level: 1, title)
    // Нумерация рисунков и таблиц — своя в каждой лекции.
    #counter(figure.where(kind: image)).update(0)
    #counter(figure.where(kind: table)).update(0)
    // Продолжение сквозной нумерации разделов между лекциями.
    #counter(heading).update((..n) => (n.pos().at(0, default: 0), start-section - 1))
    // Сдвиг заголовков ограничен телом лекции: заголовок списка литературы
    // должен остаться заголовком первого уровня.
    #{
      set heading(offset: 1)
      body
    }
    #if bib != none and not in-book {
      bibliography(bib, title: [Список литературы], style: "ieee")
    }
  ]
}
