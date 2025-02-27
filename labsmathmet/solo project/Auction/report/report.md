---
## Front matter
title: "Доклад"
subtitle: "Аукцион второй цены"
author: "Морозов Михаил Евгеньевич"

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
lot: true # List of tables
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

# Вводная часть
## Цель работы

Изучить понятие аукциона второй цены и построить математическую модель аукциона.

## Задачи

- Изучение аукциона второй цены

- Математическая модель аукциона

- Реализация модели и пример

- Анализ модели

## Определение

Аукцион Викри (или аукцион второй цены) - это форма однораундного закрытого аукциона, в котором участники делают ставки без знания ставок друг друга. В этом типе аукциона право на покупку получает участник, предложивший максимальную ставку, но фактическая цена покупки определяется по второй максимальной ставке. Этот аукцион способствует стимулированию участников делать ставки, основанные на их истинной оценке ценности товара.[@vick:bash]

## Области применения

1.Рекламные площадки в интернете: Крупные компании, такие как Google, Yahoo и Яндекс, используют аукционы второй цены для продажи рекламного пространства. 

2.Финансовые рынки: Аукционы Викри могут использоваться для торговли финансовыми инструментами, такими как облигации или деривативы, где участники могут делать ставки на покупку или продажу активов.

3.Коллекционирование и искусство: В аукционах по продаже коллекционных предметов, таких как марки, монеты, произведения искусства.

4.Сфера недвижимости: В некоторых случаях аукционы второй цены могут применяться для продажи недвижимости или земельных участков.


# Основная часть

## Математическая модель Механизм Викри-Кларка-Гровса (VCG auction)

Предположим, что у нас есть $N$ участников и $M$ предметов на продажу. Каждый участник $i$ делает ставку за каждый предмет .

1. **Определение победителей:**
   - Победители определяются как участники, которые максимизируют общую сумму их ставок для всех предметов, но при этом не получают никаких предметов. 
2. **Расчет платежей:**
   - Каждый участник платит по итогам аукциона сумму, равную недополученной ценности товаров другими игроками из-за того, что в аукционе участвует этот игрок.

[@vick:bash]


## Реализация на основе конкретной задаче

### Задача: Аукцион рекламных мест

Допустим, у нас есть несколько рекламодателей, конкурирующих за рекламные места на интернет-площадке. Предположим, что у нас есть 5 рекламодателей и 3 рекламных места на странице.

Допустим, ставки рекламодателей за каждое рекламное место случайны и выглядят следующим образом:

| Рекламодатель | Ставка за место 1 ($) | Ставка за место 2 ($) | Ставка за место 3 ($) |
|---------------|-----------------------|-----------------------|-----------------------|
| Рекламодатель 1 | 7 | 5 | 8 |
| Рекламодатель 2 | 4 | 6 | 9 |
| Рекламодатель 3 | 8 | 3 | 5 |


```julia
# Функция для нахождения второй по величине ставки
function find_second_highest_bid(bids, winner_index, place_index)
    other_bids = setdiff(bids[:, place_index], [bids[winner_index, place_index]])
    if isempty(other_bids)
        return 0
    else
        return maximum(other_bids)
    end
end

# Функция для нахождения третьей по величине ставки
function find_third_highest_bid(bids, winner_index, place_index)
    other_bids = setdiff(bids[:, place_index], [bids[winner_index, place_index]])
    sorted_bids = sort(other_bids, rev=true)
    if length(sorted_bids) < 2
        return 0
    else
        return sorted_bids[2]
    end
end

# Определение функции для расчета платежей и определения победителя
function calculate_payments_and_winner(bids)
    num_participants, num_items = size(bids)
    payments = zeros(num_participants)
    winners = Vector{Int}(undef, num_items)
    
    # Проходим по каждому месту
    for j in 1:num_items
        # Находим победителя для текущего места
        winner = argmax(bids[:, j])
        winners[j] = winner
        
        # Находим вторую по величине ставку для следующего места, если это не последний элемент
        next_highest_bid = 0
        if j < num_items
            next_highest_bid = find_second_highest_bid(bids, winner, j+1)
        end

        # Находим третью по величине ставку для следующего места, если это не последний элемент
        third_highest_bid = 0
        if j < num_items
            third_highest_bid = find_third_highest_bid(bids, winner, j+1)
        end
        
        # Рассчитываем платежи
        payment = bids[winner, j] - next_highest_bid - third_highest_bid
        payments[winner] += payment
    end
    
    return payments, winners
end

# Ставки рекламодателей за каждое место
bids = [
    7 5 8;
    4 6 9;
    8 3 5;
]

# Расчет платежей и определение победителя для каждого места
payments, winners = calculate_payments_and_winner(bids)

# Вывод результатов
for j in 1:length(winners)
    winner = winners[j]
    payment = payments[winner] < 0 ? -payments[winner] : payments[winner]
    println("Место ", j, ": Победитель - Рекламодатель ", winner, " и его платеж ", payment)
end
```

![Вывод программы на джулия](1.png){ #fig:001 width=70% }


##  Анализ
1.Преимущества модели: Аукцион второй цены обладает рядом преимуществ, таких как справедливость распределения ресурсов (победитель оплачивает сумму, соответствующую его реальной оценке предмета), стимулирование участников делать обоснованные ставки и минимизация рисков переплаты.

2.Ограничения модели: Однако модель аукциона второй цены также имеет свои ограничения. Например, участники могут использовать стратегии манипулирования ставками, чтобы влиять на конечную цену товара, а также существует риск "победы с низкой ставкой", когда победитель получает товар по цене значительно ниже его реальной стоимости.

3.Эффективность и конкуренция: Эффективность модели зависит от уровня конкуренции между участниками. Большая конкуренция обычно приводит к более высоким ценам и справедливому распределению ресурсов.

[@wiki:bash]

# Выводы
Я представил математическую модель аукциона второй цены (аукциона Викри) и обозначил его применение в различных областях, таких как финансовые рынки, коллекционирование и недвижимость. Модель обладает рядом преимуществ, включая справедливое распределение ресурсов и стимулирование обоснованных ставок. Однако для оптимальных результатов необходимо учитывать возможные стратегии манипулирования ставками и обеспечивать эффективную конкуренцию.

# Список литературы{.unnumbered}

::: {#refs}
:::
