---
## Front matter
title: "Групповой проект. Тема: Рост дендритов"
subtitle: "Этап 1"
author: |
	Артамонов Тимофей Евгеньевич
	\and
	Федорина Эрнест Васильевич
	\and
	Морозов Михаил Евгеньвич
	\and
	Коротун Илья Игоревич
	\and
	Маслова Анастасия Сергеевна
institute: RUDN University, Moscow, Russian Federation

## Generic otions
lang: ru-RU
toc-title: "Содержание"

## Bibliography
bibliography: bib/cite.bib
csl: pandoc/csl/gost-r-7-0-5-2008-numeric.csl

## Pdf output format
toc: true # Table of contents
toc-depth: 2
lof: true # List of figures
lot: false # List of tables
fontsize: 12pt
linestretch: 1.5
papersize: a4
documentclass: scrreprt
## I18n polyglossia
polyglossia-lang:
  name: russian
  options:
	- spelling=modern
	- babelshorthands=true
polyglossia-otherlangs:
  name: english
## I18n babel
babel-lang: russian
babel-otherlangs: english
## Fonts
mainfont: PT Serif
romanfont: PT Serif
sansfont: PT Sans
monofont: PT Mono
mainfontoptions: Ligatures=TeX
romanfontoptions: Ligatures=TeX
sansfontoptions: Ligatures=TeX,Scale=MatchLowercase
monofontoptions: Scale=MatchLowercase,Scale=0.9
## Biblatex
biblatex: true
biblio-style: "gost-numeric"
biblatexoptions:
  - parentracker=true
  - backend=biber
  - hyperref=auto
  - language=auto
  - autolang=other*
  - citestyle=gost-numeric
## Pandoc-crossref LaTeX customization
figureTitle: "Рис."
tableTitle: "Таблица"
listingTitle: "Листинг"
lofTitle: "Список иллюстраций"
lotTitle: "Список таблиц"
lolTitle: "Листинги"
## Misc options
indent: true
header-includes:
  - \usepackage{indentfirst}
  - \usepackage{float} # keep figures where there are in the text
  - \floatplacement{figure}{H} # keep figures where there are in the text
---

# Введение

Дендриты — это древовидные кристаллические структуры, которые образуются в процессе кристаллизации из переохлажденного расплава. Они играют ключевую роль в определении микроструктуры и, следовательно, физических свойств материалов. Процесс роста дендритов зависит от множества факторов. Если исследовать механизм формирования дендритов, то можно научиться изменять свойства различных сплавов, а значит исследование полезно не только для теории, но и для практики.

# Формирование и описание научной проблемы

## Проблема управления и предсказания морфологии дендритной кристаллизации в переохлажденных расплавах

В процессе формирования кристаллических структур из переохлажденных расплавов ключевым является понимание и управление механизмами роста дендритов, поскольку именно они определяют конечные физические свойства материалов. Дендритный рост, происходящий в результате кристаллизации, существенно влияет на микроструктуру и, как следствие, на механические, электрические и тепловые характеристики материалов. Особенностью дендритного роста является его чувствительность к множеству факторов, включая переохлаждение расплава, скорость охлаждения, наличие примесей и поверхностное натяжение. Таким образом, научная проблема заключается в разработке теоретических и численных моделей, способных точно предсказывать динамику роста дендритов и их влияние на микроструктуру сформированных материалов.

Решение этой проблемы откроет новые возможности для оптимизации процессов производства материалов с высокими эксплуатационными характеристиками и для создания новых материалов с уникальными свойствами.

# Алгоритм модели роста дендритов

- Написать программу, моделирующую теплопроводность. Задать начальную температуру равной нулю везде, кроме центральной точки и посмотреть, как меняется распределение температуры.
- Добавить затвердевание, исследовать влияние начального переохлаждения S и величины капиллярного радиуса λ на форму образующихся дендритов.
- Исследовать зависимость от времени числа частиц в агрегате и его среднеквадратичного радиуса в разных режимах.
- Определить фрактальную размерность полученных образцов
- Исследуйте, как влияет величина теплового шума δ на вид образующихся агрегатов.

# Важные формулы

- **Безразмерное переохлаждение:**
$$S = \frac{c_p (T_m - T_\infty)}{L}$$

- **Уравнение теплопроводности:**
$$\rho c_p \frac{\partial T}{\partial t} = \kappa \nabla^2 T$$

- **Условие Стефана для скорости \(V\):**
$$V = \frac{\kappa}{\rho L} (\nabla T|_s - \nabla T|_l)$$

- **Условие Гиббса-Томсона:**
$$T_b = T_m \left(1 - \frac{\gamma T_m}{\rho L^2 R}\right)$$

- **Кинетическая модификация температуры на границе:**
$$\Delta T_b = -T_m \beta V$$

# Список литературы{.unnumbered}

::: {#refs}
:::