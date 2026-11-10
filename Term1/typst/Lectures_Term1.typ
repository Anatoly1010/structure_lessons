// ============================================================
//  Курс лекций по строению вещества. Часть 1 — сборник из пятнадцати лекций.
//  Файлы лекций подключаются без изменений и по-прежнему собираются поодиночке.
//
//    typst compile --font-path ../../fonts --input book=1 Lectures_Term1.typ
//
//  Флаг --input book=1 обязателен: без него каждая лекция печатает свой
//  список литературы, а Typst допускает лишь один список на документ.
// ============================================================

#import "lecture.typ": *

#if not in-book {
  panic("Сборник собирается с флагом --input book=1")
}

#set document(
  title: "Курс лекций по строению вещества. Часть 1. Строение атомов и молекул",
  author: "Мельников А. Р.",
)

// --- Обложка ---
#page(paper: "a5", margin: 0pt, header: none, footer: none, numbering: none,
  image("figures/cover_v2_kran.png", width: 100%, height: 100%, fit: "cover"))

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

    #text(size: 10pt)[Часть 1. Строение атомов и молекул]

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
  // и номер рисунка «15.1» превращается в «17.1».
  #heading(level: 1, numbering: none, outlined: false)[Предисловие]
  #set par(first-line-indent: 0pt, spacing: 1em)

  Настоящее пособие представляет собой конспект лекций к годовому курсу
  «Строение вещества», преподаваемому на химическом отделении факультета
  естественных наук Новосибирского государственного университета. Курс разбит
  на два блока, соответствующих осеннему и весеннему семестру. Первый блок
  содержит пятнадцать лекций, посвящённых строению атомов и молекул: от
  оператора углового момента и атома водорода до метода Хюккеля и теории
  возмущений в применении к $pi$-сопряжённым системам. Изложение следует программе курса
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
  // numbering: none — по той же причине, что и у предисловия.
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
      [ВЗМО], [высшая занятая молекулярная орбиталь],
      [ВФ], [волновая функция],
      [ИК], [инфракрасный диапазон],
      [ИРС], [индекс реакционной способности],
      [КВ], [кратность вырождения],
      [КЭ], [класс эквивалентности],
      [ЛКАО], [линейная комбинация атомных орбиталей],
      [МО], [молекулярная орбиталь],
    ),
    grid(
      columns: (auto, 1fr),
      column-gutter: 1.2em,
      row-gutter: 0.6em,
      [НП], [неприводимое представление],
      [СКАО], [симметризованная комбинация атомных орбиталей],
      [ТФП], [теория функционала плотности],
      [УФ], [ультрафиолетовый диапазон],
      [ЭК], [электронная конфигурация],
      [ЭМ], [электромагнитный],
      [ЭПР], [электронный парамагнитный резонанс],
      [DFT], [density functional theory, теория функционала плотности],
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

#include "Lesson_1_Angular_momentum_Hydrogen_atom_Spin.typ"
#include "Lesson_2_Helium_Pauli_Spin_orbit.typ"
#include "Lesson_3_Atomic_terms_LS_coupling_Hunds_rules.typ"
#include "Lesson_4_jj_coupling_Hartree_Fock_Approximate_orbitals.typ"
#include "Lesson_5_Selection_rules_Total_momentum_Zeeman_effect.typ"
#include "Lesson_6_Paschen_Back_effect_Starck_effect_Wigner_Witmer_rules.typ"
#include "Lesson_7_Born_Oppenheimer_MO_LCAO_Rayleigh_Ritz_method_Huckel_method.typ"
#include "Lesson_8_Dihydrogen_Dioxygen_Dinitrogen.typ"
#include "Lesson_9_Group_Theory_for_Chemists.typ"
#include "Lesson_10_Description_of_pi_conjugate_systems_by_the_Huckel_method.typ"
#include "Lesson_11_Alternant_systems.typ"
#include "Lesson_12_Cyclic_and_Linear_Systems.typ"
#include "Lesson_13_Perturbations_in_Huckel_method.typ"
#include "Lesson_14_Substituent_Theory_Second_Order_Perturbation_Theory.typ"
#include "Lesson_15_Level_Anticrossings_Thomas_Fermi_Model.typ"

// --- Список литературы ---
#base-style[
  #bibliography(
    "references.bib",
    title: [Список литературы],
    style: "ieee",
    full: true,
  )
]
