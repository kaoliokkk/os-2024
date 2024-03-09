---
## Front matter
title: "Групповой проект. Тема: Рост дендритов"
subtitle: "Этап 3"
author: 
	- Артамонов Тимофей Евгеньевич 
	- Федорина Эрнест Васильевич
	- Морозов Михаил Евгеньвич
	- Коротун Илья Игоревич
	- Маслова Анастасия Сергеевна
	
institute: RUDN University, Moscow, Russian Federation

## Generic options
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

На третьем этапе группового проекта нужно описание программную реализацию проекта. На прошлом этапе мы уже рассмотрели алогритм по которому мы будем двигаться при выполнении этого этапа. Приступим к описанию кода.

# Моделирование роста дендритов

## Шаг 0 используемые библиотеки 

- using Plots: Библиотека для визуализации данных. В данном коде используем для создания тепловой карты, отображающей состояние сетки после симуляции роста дендритов.
- using LinearAlgebra: Библиотека для работы с линейной алгеброй. Используем, для операций с векторами и матрицами в вычислениях.


```Julia

using Plots
using LinearAlgebra

```
## Шаг 1 Параметры модели

Указываем основные параметрыры моделирования:

N: размер сетки, представляющий собой квадратную сетку N x N, на которой будет происходить моделирование.
T_melt: температура плавления, определяющая порог, при котором материал начинает затвердевать.
growth_chance: увеличенный шанс роста дендритов в соседние ячейки, это вероятность, с которой новые дендриты будут расти в окружающие зоны с пониженной температурой.
steps: количество шагов симуляции, определяющее, сколько раз будет произведено обновление состояния сетки.



```Julia

N = 100                  
T_melt = 1.0             
growth_chance = 0.005     
steps = 8000              

```
## Шаг 2 Инициализация сетки
Создаем матрицу T размером N x N, инициализируя ее нулями.
Задаем начальную затравочную область в виде круга с заданным радиусом и центром.


```Julia
T = zeros(N, N)

# Увеличение размера начальной затравочной области
center = div(N, 2)
radius = 1  # Радиус затравочной области
for i in (center-radius):(center+radius)
    for j in (center-radius):(center+radius)
        T[i, j] = T_melt
    end
end
          
```

## Шаг 3 Параметры для условия Стефана
Определяем коэффициенты теплопроводности, плотности, латентной теплоты и температуру на границе.
Используем эти парамметры для вычисления скорости роста кристалла по условию Стефана.

```Julia
κ = 0.1   # Теплопроводность
ρ = 1.0   # Плотность
L = 1.0   # Латентная теплота
Tb = T_melt  # Температура на границе

```
## Шаг 4 Функция роста
Эта функция выполняет основную часть моделирования роста дендритов. Она итерирует указанное количество шагов по сетке и обновляет ее состояние в соответствии с правилами роста кристалла и уравнением теплопроводности.



Уравнение теплопроводности:
1.Создается временная копия текущего состояния сетки T.
2.Перебираются все внутренние ячейки сетки.
3.Если температура в ячейке равна температуре плавления, вычисляется градиент температуры в соседних ячейках.
4.Для каждой соседней ячейки вычисляется градиент температуры и скорость роста кристалла по условию Стефана.
5.Если случайное число меньше произведения шанса роста на скорость роста, ячейка затвердевает на следующем шаге, и это отражается во временной копии сетки.



Обновление основной сетки:
        После завершения всех шагов симуляции, основная сетка T обновляется копией T_temp.

```Julia
function grow_crystals_stefan!(T)
    for step in 1:steps
        T_temp = copy(T)  # Создаем временную копию для текущего шага
        for i in 2:N-1
            for j in 2:N-1
                if T[i, j] == T_melt
                    for di in -1:1
                        for dj in -1:1
                            if T[i+di, j+dj] == 0
                                # Вычисляем градиенты температуры в соседних ячейках
                                ∇T_s = [T[i+di, j+dj] - T[i, j] for (di, dj) in [(-1, 0), (1, 0), (0, -1), (0, 1)]]
                                ∇T_l = [Tb - T[i, j] for _ in 1:4]
                                # Умножаем градиенты для диагональных элементов на 2
                                ∇T_s[1] /= 2
                                ∇T_s[2] /= 2
                                # Вычисляем вектор нормали к границе затвердевания
                                n = [di + dj for (di, dj) in [(-1, 0), (1, 0), (0, -1), (0, 1)]]
                                # Вычисляем скорость роста кристалла по условию Стефана
                                v = κ / (ρ * L) * dot(n, ∇T_s - ∇T_l)
                                if rand() < growth_chance * v
                                    T_temp[i+di, j+dj] = T_melt  # Затвердевание на следующем шаге
                                end
                            end
                        end
                    end
                end
            end
        end
        T .= T_temp  # Обновляем основную сетку
    end
end

```

## Шаг 5 Визуализация итогового состояния
После выполнения симуляции функцией роста, код строит тепловую карту (heatmap) для визуализации конечного состояния сетки T.
ания от инициализации параметров до анализа результатов имеет свою важную роль в создании полной картины процесса.

```Julia

#Выполнение симуляции
grow_crystals_stefan!(T)

#Визуализация итогового состояния
p = heatmap(T, color=:ice, aspect_ratio=1, title="Модель роста дендритов с условием Стефана")
display(p)
```
#Вывод
Модель роста дендритов, реализованная с использованием условия Стефана и уравнения теплопроводности, позволяет имитировать процесс затвердевания материала и формирования кристаллических структур.После завершения всех шагов симуляции, модель предоставляет визуализацию итогового состояния сетки с помощью тепловой карты. 
# Список литературы{.unnumbered}

::: {#refs}
:::
