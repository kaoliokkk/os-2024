---
## Front matter
title: "Отчёт по лабораторной работе №5"
subtitle: "Модель хищник-жертва"
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

# Цель работы

1. Построить график зависимости $x$ от $y$ и графики функций $x(t)$, $y(t)$
2. Найти стационарное состояние системы
  
# Теоретическое введение
Простейшая модель взаимодействия двух видов типа «хищник — жертва» - модель Лотки-Вольтерры. Данная двувидовая модель основывается на следующих предположениях:

1. Численность популяции жертв x и хищников y зависят только от времени (модель не учитывает пространственное распределение популяции на занимаемой территории)
2. В отсутствии взаимодействия численность видов изменяется по модели Мальтуса, при этом число жертв увеличивается, а число хищников падает
3. Естественная смертность жертвы и естественная рождаемость хищника считаются несущественными
4. Эффект насыщения численности обеих популяций не учитывается
5. Скорость роста численности жертв уменьшается пропорционально численности хищников

$$\dfrac{dx}{dt}$ = $-ax(t)-bx(t)y(t)$$
$$\dfrac{dy}{dt}$ = $-cx(t)+dx(t)y(t)$$

В этой модели $x$ – число жертв, $y$ - число хищников. Коэффициент a описывает скорость естественного прироста числа жертв в отсутствие хищников, $с$ - естественное вымирание хищников, лишенных пищи в виде жертв. Вероятность взаимодействия жертвы и хищника считается пропорциональной как количеству жертв, так и числу самих хищников $(xy)$. Каждый акт взаимодействия уменьшает популяцию жертв, но способствует увеличению популяции хищников (члены $-bxy$ и $dxy$ в правой части уравнения).

# Постановка задачи

Лабораторная работа $№ 4 Задача$
В лесу проживают х число волков, питающихся зайцами, число которых в этом же лесу у. Пока число зайцев достаточно велико, для прокормки всех волков, численность волков растет до тех пор, пока не наступит момент, что корма перестанет хватать на всех. Тогда волки начнут умирать, и их численность будет уменьшаться. В этом случае в какой-то момент времени численность зайцев снова начнет увеличиваться, что повлечет за собой новый рост популяции волков. Такой цикл будет повторяться, пока обе популяции будут существовать. Помимо этого, на численность стаи влияют болезни и старение. Данная модель описывается следующим уравнением:

$a,d$ - коэффициенты смертности
$b,c$ - коэффициенты прироста популяции
1. Построить график зависимости $x$ от $y$ и графики функций $x(t)$, $y(t)$
2. Найти стационарное состояние системы


# Задание 

Для модели «хищник-жертва»:
$$\dfrac{dx}{dt}$ = $-0.54x(t)-0.031x(t)y(t)$$
$$\dfrac{dy}{dt}$ = $-0.62x(t)+0.07x(t)y(t)$$



Постройте график зависимости численности хищников от численности жертв, а также графики изменения численности хищников и численности жертв при
следующих начальных условиях: $x0=10$, $y0=30$.
Найдите стационарное состояние системы.



# Выполнение лабораторной работы

Написали код на Julia:
```julia
using DifferentialEquations
using Plots
using OrdinaryDiffEq

#Начальные условия
p=[0.54,0.031,0.62,0.07]
x0=10
y0=30

tspan=(0,50)

#функция
function lotka_volt(u,p,t)
    x,y = u
    a, b, c, d = p
    dx = -a*x + b*x*y
    dy = c*y - d*x*y
    return[dx,dy]
end

#cтационарное сост
x1 = p[3]/p[4]  
y1 = p[1]/p[2]

#опред проблемы
prob1 = ODEProblem(lotka_volt,[x0,y0],tspan,p)
prob2 = ODEProblem(lotka_volt,[x1,y1],tspan,p)

#опред решения
sol1 = solve(prob1, Tsit5(), dtmax=0.05)
sol2 = solve(prob2, Tsit5(), dtmax=0.05)

#графики для 1 и 2 случая а также фазовые портреты.
plot(sol1, title = "Точки x0, y0")
plot(sol1, vars = (2,1), title = "Точки x0, y0")
plot(sol2, title = "Стац. точка")
scatter(sol2, vars = (2,1), title = "Точки x0, y0")
```

Записали 2 случая на языке OpenModelica 
```
model lab5

parameter Real a = 0.54;
parameter Real b = 0.031;
parameter Real c = 0.62;
parameter Real d = 0.07;

Real x(start = 10);
Real y(start = 30);

equation
  der(x) = -a*x + b*x*y;
  der(y) = c*y - d*x*y;

end lab5;



model lab5

parameter Real a = 0.54;
parameter Real b = 0.031;
parameter Real c = 0.62;
parameter Real d = 0.07;

Real x(start = c/d);
Real y(start = a/b);

equation
  der(x) = -a*x + b*x*y;
  der(y) = c*y - d*x*y;

end lab5;


```

и получили следующие результаты.




Для первого случая в Julia (график и фазовый портрет:

![График сл 1 джулия](image/jl1.png){ #fig:001 width=70% }



![Фазовый портрет сл 1 джулия](image/jl1p.png){ #fig:002 width=70% }

Для первого случая в Open Modelica(график и фазовый портрет:

![График сл 1 моделика](image/om1.png){ #fig:003 width=70% }



![Фазовый портрет сл 1 моделика](image/om1p.png){ #fig:004 width=70% }

Для второго случая в Julia (график и фазовый портрет:

![График сл 1 джулия](image/jl2.png){ #fig:005 width=70% }



![Фазовый портрет сл 1 джулия](image/jl2p.png){ #fig:006 width=70% }

Для первого случая в Open Modelica(график и фазовый портрет:

![График сл 1 моделика](image/om2.png){ #fig:007 width=70% }



![Фазовый портрет сл 1 моделика](image/om2p.png){ #fig:008 width=70% }

# Выводы

- Построили график зависимости численности хищников от численности жертв, а также графики изменения численности хищников и численности жертв при
следующих начальных условиях: $x_0 = 10$, $y_0 = 30$.
- Нашли стационарное состояние системы.
- Сравнили результаты на Julia и OpenModelica.

# Список литературы{.unnumbered}

::: {#refs}
:::
