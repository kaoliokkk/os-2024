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

Аукцион Викри (или аукцион второй цены) - это форма однораундного закрытого аукциона, в котором участники делают ставки без знания ставок друг друга. В этом типе аукциона право на покупку получает участник, предложивший максимальную ставку, но фактическая цена покупки определяется по второй максимальной ставке. Этот аукцион способствует стимулированию участников делать ставки, основанные на их истинной оценке ценности товара.

## Области применения

1.Рекламные площадки в интернете: Крупные компании, такие как Google, Yahoo и Яндекс, используют аукционы второй цены для продажи рекламного пространства. 

2.Финансовые рынки: Аукционы Викри могут использоваться для торговли финансовыми инструментами, такими как облигации или деривативы, где участники могут делать ставки на покупку или продажу активов.

3.Коллекционирование и искусство: В аукционах по продаже коллекционных предметов, таких как марки, монеты, произведения искусства.

4.Сфера недвижимости: В некоторых случаях аукционы второй цены могут применяться для продажи недвижимости или земельных участков.


# Основная часть

## Математическая модель Механизм Викри-Кларка-Гровса (VCG auction)

Предположим, что у нас есть \( N \) участников и \( M \) предметов на продажу. Каждый участник \( i \) делает ставку \( b_{ij} \) за каждый предмет \( j \).

1. **Определение победителей:**
   - Победители определяются как участники, которые максимизируют общую сумму их ставок для всех предметов, но при этом не получают никаких предметов. Мы можем записать это следующим образом:

   \[ \text{Победитель } i: \max \left( \sum_{j=1}^{M} b_{ij} - \sum_{k \neq i} \sum_{j=1}^{M} b_{kj} \right) \]

2. **Расчет платежей:**
   - Платеж каждого участника \( i \) рассчитывается как разница между стоимостью, которую он бы заплатил, если бы победителем был кто-то другой, и стоимостью, которую он платит как победитель. Мы можем записать это как:

   \[ \text{Платеж } i: \sum_{k \neq i} \sum_{j=1}^{M} b_{kj} - \sum_{j=1}^{M} b_{ij} \]


## Математическая модель механизма Викри-Кларка-Гровса (VCG) в аукционе второй цены для интернет-рекламы

1. **Условные обозначения:**
   - \( N \) - количество рекламных объявлений.
   - \( M \) - количество рекламных мест на площадке.
   - \( K \) - количество доступных для продажи рекламных мест.
   - \( b_{ij} \) - ставка \( i \)-го объявления за клик на \( j \)-ом месте.
   - \( p_{ij} \) - вероятность клика на \( j \)-ом месте по объявлению \( i \).
   - \( V(b_{ij}, p_{ij}) \) - ценность объявления \( i \) на месте \( j \), равная \( V(b_{ij}, p_{ij}) = b_{ij} \cdot p_{ij} \).

2. **Определение победителей:**
   - Выбираются \( K \) рекламных объявлений с наивысшей ценностью \( V \) среди всех \( N \) объявлений.

3. **Расчет стоимости кликов:**
   - Для каждого не выбранного в показ объявления рассчитывается стоимость клика \( c_i \).
   - Ставка \( i \)-го объявления уменьшается настолько, чтобы его новая ценность \( V(c_i, p_{ij}) \) была равна ценности объявления, которое стало бы показано на его месте вместо него, если бы объявление \( i \) не участвовало в аукционе.

4. **Формула для расчета стоимости кликов:**
   \[ c_i = \frac{b_{max} \cdot p_{max}}{p_{i}} \]
   где \( b_{max} \) - ставка за клик на рекламное объявление с наивысшей ставкой, \( p_{max} \) - соответствующая ей вероятность клика, а \( p_i \) - вероятность клика на рекламное объявление \( i \).

5. **Пример:**
   - Пусть \( N = 4 \) - четыре рекламных объявления.
   - Пусть \( K = 3 \) - три рекламных места доступны для продажи.
   - Объявления имеют следующие ставки за клик: \( b_1 = 10, b_2 = 7, b_3 = 5, b_4 = 2 \).
   - Соответствующие им вероятности клика: \( p_1 = 0.1, p_2 = 0.2, p_3 = 0.3, p_4 = 0.4 \).
   - Рассчитаем стоимость кликов для каждого объявления:
     - \( c_1 = \frac{2 \cdot 0.4}{0.1} = 8 \)
     - \( c_2 = \frac{2 \cdot 0.4}{0.2} = 4 \)
     - \( c_3 = \frac{2 \cdot 0.4}{0.3} \approx 2.67 \)
     - \( c_4 = \frac{2 \cdot 0.4}{0.4} = 2 \)

Эта модель позволяет определить победителей и рассчитать стоимость кликов в аукционе второй цены для интернет-рекламы с использованием механизма Викри-Кларка-Гровса (VCG).


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

![Вывод программы на джулия](image/1.png){ #fig:001 width=70% }


##  Анализ
1.Преимущества модели: Аукцион второй цены обладает рядом преимуществ, таких как справедливость распределения ресурсов (победитель оплачивает сумму, соответствующую его реальной оценке предмета), стимулирование участников делать обоснованные ставки и минимизация рисков переплаты.

2.Ограничения модели: Однако модель аукциона второй цены также имеет свои ограничения. Например, участники могут использовать стратегии манипулирования ставками, чтобы влиять на конечную цену товара, а также существует риск "победы с низкой ставкой", когда победитель получает товар по цене значительно ниже его реальной стоимости.

3.Эффективность и конкуренция: Эффективность модели зависит от уровня конкуренции между участниками. Большая конкуренция обычно приводит к более высоким ценам и справедливому распределению ресурсов.


# Выводы
Я представил математическую модель аукциона второй цены (аукциона Викри) и обозначил его применение в различных областях, таких как финансовые рынки, коллекционирование и недвижимость. Модель обладает рядом преимуществ, включая справедливое распределение ресурсов и стимулирование обоснованных ставок. Однако для оптимальных результатов необходимо учитывать возможные стратегии манипулирования ставками и обеспечивать эффективную конкуренцию.

# Список литературы{.unnumbered}

::: {#refs}
:::