// ============================================================
//  Курс лекций по строению вещества. Часть 2 — сборник лекций.
//  Файлы лекций подключаются без изменений и по-прежнему собираются поодиночке.
//
//    typst compile --font-path ../../fonts --input book=1 Lectures_Term2.typ
//
//  Флаг --input book=1 обязателен: без него каждая лекция печатает свой
//  список литературы, а Typst допускает лишь один список на документ.
//
// ============================================================

#import "lecture.typ": *

#if not in-book {
  panic("Сборник собирается с флагом --input book=1")
}

#set document(
  title: "Курс лекций по строению вещества. Часть 2. Спектроскопические методы",
  author: "Мельников А. Р.",
)

// --- Обложка ---
#page(paper: "a5", margin: 0pt, header: none, footer: none, numbering: none,
  image("fig/cover_kran_term2.png", width: 100%, height: 100%, fit: "cover"))

// --- Титульный лист ---
// Общее оформление здесь не применяется: правило о коротких словах съедает
// принудительный перенос перед «ПО».
#page(paper: "a5", margin: (x: 1.3cm, top: 2.2cm, bottom: 2cm),
  header: none, footer: none, numbering: none)[
  #set text(font: "Noto Serif", lang: "ru", size: 8pt)
  #set par(justify: false)
  #align(center)[
    НОВОСИБИРСКИЙ ГОСУДАРСТВЕННЫЙ УНИВЕРСИТЕТ \
    КАФЕДРА ФИЗИЧЕСКОЙ ХИМИИ

    #v(1.6cm)

    #text(size: 15pt, weight: "bold")[
      КУРС ЛЕКЦИЙ \
      ПО СТРОЕНИЮ ВЕЩЕСТВА
    ]

    #v(0.2cm)
    #line(length: 30%, stroke: 0.7pt)
    #v(0.2cm)

    #text(size: 10pt)[Часть 2. Спектроскопические методы]

    #v(1.4cm)

    #text(size: 9pt)[Мельников А. Р.]
  ]
]

// Нумерация рисунков в сборнике — по лекциям: «рис. 7.2».
#set figure(numbering: n => context {
  numbering("1.1", counter(heading).get().at(0, default: 0), n)
})

#set page(..page-cfg)
#set page(numbering: "i")

// --- Предисловие ---
#base-style[
  // numbering: none — иначе предисловие и оглавление считаются лекциями
  // и номер рисунка «13.1» превращается в «15.1».
  #heading(level: 1, numbering: none, outlined: false)[Предисловие]
  #set par(first-line-indent: 0pt, spacing: 1em)

  Настоящее пособие представляет собой конспект лекций к годовому курсу
  «Строение вещества», преподаваемому на химическом отделении факультета
  естественных наук Новосибирского государственного университета. Курс разбит
  на два блока, соответствующих осеннему и весеннему семестру. Второй блок
  содержит четырнадцать лекций, посвящённых приложениям теории симметрии
  и спектроскопическим методам исследования вещества: от правил
  Вудворда—Хоффмана и строения
  координационных соединений до электронной, колебательной и вращательной
  спектроскопии и магнитного резонанса. Изложение следует программе курса
  и опирается на литературу, приведённую
  в конце книги. Задачи к курсу собраны в отдельном сборнике.
  Нумерация разделов своя в каждой лекции, нумерация рисунков — сквозная
  внутри лекции: «рис. 7.2» означает второй рисунок седьмой лекции. При чтении
  пособия в электронном виде названия лекций и разделов в оглавлении, а также
  ссылки на рисунки в тексте являются гиперссылками.

  Материал с заголовком на сером фоне является дополнительным. Это отступления, подробные выводы
  и справочные сведения, которые на лекциях не разбираются и при первом чтении
  могут быть пропущены. Принятые сокращения собраны в списке перед оглавлением.

  О возможных ошибках в изложении, опечатках в формулах или в справочных данных
  просьба сообщать по электронной почте: anatoly.melnikov\@tomo.nsc.ru
]

// --- Список сокращений ---
#base-style[
  #heading(level: 1, numbering: none, outlined: false)[Список сокращений]
  // leading плотнее обычного: расшифровка в две строки не должна разрывать список.
  #set par(first-line-indent: 0pt, justify: false, leading: 0.45em)
  // две независимые половины: строки в них не выравниваются друг с другом
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 1.6em,
    align: top,
    grid(
      columns: (auto, 1fr),
      column-gutter: 1.2em,
      row-gutter: 0.6em,
      [АО], [атомная орбиталь],
      [АЦП], [аналого-цифровой преобразователь],
      [ВЗМО], [высшая занятая молекулярная орбиталь],
      [ВФ], [волновая функция],
      [ИК], [инфракрасный],
      [КД], [круговой дихроизм],
      [КП], [кристаллическое поле],
      [КР], [комбинационное рассеяние],
      [ЛКАО], [линейная комбинация атомных орбиталей],
      [МО], [молекулярная орбиталь],
      [МШУ], [малошумящий усилитель],
      [НП], [неприводимое представление],
      [НПВО], [нарушенное полное внутреннее отражение],
      [ПЗС], [прибор с зарядовой связью],
      [РЧ], [радиочастотный],
      [ССИ], [спад свободной индукции],
      [СТВ], [сверхтонкое взаимодействие],
      [ТВ], [теория возмущений],
      [ТКП], [теория кристаллического поля],
      [ТМС], [тетраметилсилан],
      [УФ], [ультрафиолетовый],
      [ФНЧ], [фильтр нижних частот],
      [ФЭУ], [фотоэлектронный умножитель],
      [ЭДС], [электродвижущая сила],
      [ЭК], [электронная конфигурация],
    ),
    grid(
      columns: (auto, 1fr),
      column-gutter: 1.2em,
      row-gutter: 0.6em,
      [ЭПР], [электронный парамагнитный резонанс],
      [ЯМР], [ядерный магнитный резонанс],
      [ATR], [attenuated total reflection (НПВО)],
      [CFD], [constant fraction discriminator],
      [CNPI], [complete nuclear permutation inversion],
      [COSY], [correlation spectroscopy],
      [ES], [возбуждённое состояние],
      [EXSY], [exchange spectroscopy],
      [FID], [free induction decay (ССИ)],
      [FRET], [Förster resonance energy transfer],
      [GS], [основное состояние],
      [HOMO], [highest occupied molecular orbital (ВЗМО)],
      [IQ], [синфазная и квадратурная компоненты],
      [LMCT], [ligand to metal charge transfer],
      [LUMO], [lowest unoccupied molecular orbital],
      [MLCT], [metal to ligand charge transfer],
      [NOESY], [nuclear Overhauser effect spectroscopy],
      [OPD], [optical path difference],
      [PEMD], [preparation, evolution, mixing, detection],
      [PHIP], [parahydrogen induced polarization],
      [SABRE], [signal amplification by reversible exchange],
      [TAC], [time to amplitude converter],
      [TCSPC], [time correlated single photon counting],
      [TOCSY], [total correlation spectroscopy],
      [ZPD], [zero path difference],
    ),
  )
]

// --- Содержание ---
#base-style[
  #heading(level: 1, numbering: none, outlined: false)[Содержание]
  // leading плотнее обычного: длинное название лекции переносится в две плотные строки.
  #set par(leading: 0.65em)
  // Записи разделов — тоже блоки: иначе sticky названию лекции не к чему прилипнуть.
  #show outline.entry.where(level: 2): it => block(above: 0.7em, it)
  // sticky: название лекции не остаётся одно внизу страницы оглавления.
  #show outline.entry.where(level: 1): it => block(above: 0.7em, sticky: true, strong(it))
  #outline(title: none, depth: 2)
]

// --- Лекции ---
// Сначала уходим на чистую страницу, и только потом сбрасываем счётчик:
// иначе номер 1 достаётся последней странице оглавления.
#pagebreak()
#set page(numbering: "1")
#counter(page).update(1)

#include "Lesson_1_Woodward_Hoffmann_rules.typ"
#include "Lesson_2_Crystal_field_theory.typ"
#include "Lesson_3_Ligand_field_theory.typ"
#include "Lesson_4_Fluorescence_anisotropy.typ"
#include "Lesson_5_Fluorescence_quenching.typ"
#include "Lesson_6_Infrared_spectroscopy.typ"
#include "Lesson_7_Raman_spectroscopy.typ"
#include "Lesson_8_Jahn_Teller_effect.typ"
#include "Lesson_9_Rotational_spectroscopy.typ"
#include "Lesson_10_EPR_in_liquid.typ"
#include "Lesson_11_Exchange_in_magnetic_resonance.typ"
#include "Lesson_12_NMR_in_liquid.typ"
#include "Lesson_13_AB_system_13C_NMR.typ"
#include "Lesson_14_Pulsed_methods.typ"

// --- Список литературы ---
#base-style[
  #bibliography(
    "references.bib",
    title: [Список литературы],
    style: "ieee",
    full: true,
  )
]
