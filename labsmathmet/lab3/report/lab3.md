---
## Front matter
title: "Лабораторная работа №3"
subtitle: "Модель Ланчестера."
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

# Цель работы

Построить математическую модель для боевых действий по условиям.

# Задание

Вариант 61

Между страной $Х$ и страной $У$ идет война. Численность состава войск исчисляется от начала войны, и являются временными функциями $x(t)$ и $y(t)$. В
начальный момент времени страна $Х$ имеет армию численностью 66 000 человек, а в распоряжении страны $У$ армия численностью в 77 000 человек. Для упрощения модели считаем, что коэффициенты $a,b,c,h$ постоянны. Также считаем $P(t)$ и
$Q(t)$ непрерывные функции.
Постройте графики изменения численности войск армии $Х$ и армии $У$ для следующих случаев:
1. Модель боевых действий между регулярными войсками
2. Модель ведение боевых действий с участием регулярных войск и партизанских отрядов

$\dfrac{dx}{dt}$ = $-ax(t)-by(t)+P(t)$
$\dfrac{dx}{dt}$ = $-cx(t)-hy(t)+Q(t)$

# Теоретическое введение

Рассмотрим некоторые простейшие модели боевых действий – модели Ланчестера. В противоборстве могут принимать участие как регулярные войска, так и партизанские отряды. В общем случае главной характеристикой соперников являются численности сторон. Если в какой-то момент времени одна из численностей обращается в нуль, то данная сторона считается проигравшей (при условии, что численность другой стороны в данный момент положительна).

# Выполнение лабораторной работы

## Теоретическое решение
Будем расписывать решение задачи для двух случаев.

Первый случай



$Модель$ $боевых$ $действий$ $между$ $регулярными$ $войсками$



Зададим коэффициент смертности, не связанных с боевыми действиями у первой армии 0,35, у второй 0,14. Коэффициенты эффективности первой и второй армии 0,49 и 0,79 соответственно. 
Функция, описывающая подход подкрепление первой армии,
$P(t)=sin(t+1)+2$


А подкрепление второй армии описывается функцией $Q(t)=cos(t+2)+1$.

Тогда получим следующую систему, описывающую противостояние между регулярными войсками $X$ и $Y$:

$\dfrac{dx}{dt}$ = $-0,35x(t)-0,79y(t)+P(t)$
$\dfrac{dx}{dt}$ = $-0,49x(t)-0,14y(t)+Q(t)$

Зададим начальные условия:
x0=66000
y0=77000


Второй случай



$Модель$ $ведение$ $боевых$ $действий$ $с$ $участием$ $регулярных$ $войск$ $и$ $партизанских$ $отрядов$



Зададим коэффициент смертности, не связанных с боевыми действиями у первой армии 0,258, у второй 0,31. Коэффициенты эффективности первой и второй армии 0,46 и 0,67 соответственно. 
Функция, описывающая подход подкрепление первой армии,$P(t)=sin(2t)+1$


А подкрепление второй армии описывается функцией $Q(t)=cos(t)+1$.

Тогда получим следующую систему, описывающую противостояние между регулярными войсками $X$ и $Y$:

$\dfrac{dx}{dt}$ = $-0,258x(t)-0,67y(t)+P(t)$
$\dfrac{dx}{dt}$ = $-0,46x(t)-0,31y(t)+Q(t)$

Зададим начальные условия:
x0=66000
y0=77000

И далее построим численное решение задачи для двух случаев.


## Построение графиков изменения численности войск

Построим графики изменения численности войск. Далее приведён код на языке Julia, решающий задачу:

```Julia

using Plots
using OrdinaryDiffEq
x0 = 66000
y0 = 77000
p1 = [0.35,0.79,0.49,0.14]
tspan = (0,1)
function f1(u,p,t)
    x,y = u
    a,b,c,h = p
    dx = -a*x-b*y + sin(t+1)+2
    dy = -c*x-h*y + cos(t+2)+1
    return[dx,dy]
end
##первый случай
prob1 = ODEProblem(f1,[x0,y0],tspan,p1)
sol1 = solve(prob1,Tsit5())
plot(sol1,title = "Модель 1",
    label = ["Army x" "Army y"],xaxis = "Time", yaxis="Soliders"
)
##второй случай
p2 = [0.258,0.67,0.46,0.31] 
function f2(u,p,t)
    x,y = u
    a,b,c,h = p
    dx = -a*x-b*y + sin(2t)+1
    dy = -c*x-h*y + cos(t)+1
    return[dx,dy]
end
prob2 = ODEProblem(f2,[x0,y0],tspan,p2)
sol2 = solve(prob2,Tsit5())
plot(sol2,title = "Модель 2",
    label = ["Army x" "Army y"],xaxis = "Time", yaxis="Soliders"
)


```

В результате получим следующие графики (рис. @fig:001, @fig:002).

![График численности армии для сл. 1](https://github.com/kaoliokkk/os-2024/blob/master/labsmathmet/lab3/report/img/l3_jul1.png){#fig:001 width=70%}

![График численности армии для сл. 2](https://github.com/kaoliokkk/os-2024/blob/master/labsmathmet/lab3/report/img/l3_jul2.png){#fig:002 width=70%}

##Код в OpenModelica
Также построим эти графики в OpenModelica.


Для первого случая
``` OpenModelica
model lab3
Real x(start=66000);
Real y(start=77000);
Real p;
Real q;

parameter Real a=0.35;
parameter Real b=0.79;
parameter Real c=0.49;
parameter Real h=0.14;

equation
  der(x) = -a*x-b*y + p;
  der(y) = -c*x-h*y + q;
  p = sin(time+1)+2;
  q = cos(time+2)+1;
end lab3;
```

Для второго случая
``` OpenModelica
model lab3
Real p;
Real q;
Real x(start=66000);
Real y(start=77000);

parameter Real a=0.258;
parameter Real b=0.67;
parameter Real c=0.46;
parameter Real h=0.31;


equation
  der(x) = -a*x-b*y + p;
  der(y) = -c*x-h*y + q;
  p = sin(2*time)+1;
  q = cos(time)+1;
end lab3;
```

В результате получим следующие графики (рис. @fig:003, @fig:004).

![График численности армии для сл. 1](https://github.com/kaoliokkk/os-2024/blob/master/labsmathmet/lab3/report/img/l3_om1.png){#fig:001 width=70%}

![График численности армии для сл. 2](https://github.com/kaoliokkk/os-2024/blob/master/labsmathmet/lab3/report/img/l3_om2.png){#fig:002 width=70%}
# Выводы
В двух случаях побеждает армия y. Мы узнали как строить начальную аналитическую модель для модели боевых действий. Для этого использовали Julia и Openmodelica.
Сделали выводы опираясь на графики описаные в этих приложениях.

# Список литературы

1. Законы_Осипова — Ланчестера. [Электронный ресурс]. Wikimedia Foundation, Inc., 2024. URL: https://ru.wikipedia.org/wiki/Законы_Осипова_—_Ланчестера.
:::
