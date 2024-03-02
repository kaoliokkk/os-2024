---
## Front matter
lang: ru-RU
title: "Лабораторная работа 4"
subtitle: "Модель гармонических колебаний"
author:
	- Морозов М. E.
institute: Российский Университет Дружбы Народов, Moscow, Russian Federation

date: 24 февраля 2024

## i18n babel
babel-lang: russian
babel-otherlangs: english

## Formatting pdf
toc: false
toc-title: Содержание
slide_level: 2
aspectratio: 169
section-titles: true
theme: metropolis
header-includes:
 - \metroset{progressbar=frametitle,sectionpage=progressbar,numbering=fraction}
 - '\makeatletter'
 - '\beamer@ignorenonframefalse'
 - '\makeatother'
---


# Вводная часть

Движение грузика на пружинке, маятника, заряда в электрическом контуре, а также эволюция во времени многих систем в физике, химии, биологии и других науках при определенных предположениях можно описать одним и тем же дифференциальным уравнением, которое в теории колебаний выступает в качестве основной модели. Эта модель называется линейным гармоническим осциллятором.
Уравнение свободных колебаний гармонического осциллятора имеет следующий вид:
$$\ddot{x}+2\gamma\dot{x}+\omega^2{x}=0$$
где $x$ – переменная, описывающая состояние системы (смещение грузика, заряд конденсатора и т.д.),gamma– параметр, характеризующий потери энергии (трение в механической системе, сопротивление в контуре),omega – собственная частота колебаний, $t$ – время.


# Цель работы

Постройте фазовый портрет гармонического осциллятора и решение уравнения гармонического осциллятора.

# Задание

Вариант 61
Фазовый портрет гармонического осциллятора и решение уравнения гармонического осциллятора для след случаев:



1. Колебания гармонического осциллятора без затуханий и без действий внешней силы $$\ddot{x}+1.1x=0$$
2. Колебания гармонического осциллятора c затуханием и без действий внешней силы $$\ddot{x}+11\dot{x}+7x=0$$
3. Колебания гармонического осциллятора c затуханием и под действием внешней силы $$\ddot{x}+12\dot{x}+8x=4cos(2t)$$



На интервале $t=(0;39)$ (шаг 0.05) с начальными условиями $x0=-1.0$, $y0=-0.1$
# Выполнение лабораторной работы

## Построение графиков колебания гармонического осциллятора и фазовых портретов

Построим графики изменения численности войск. Далее приведён код на языке Julia, решающий задачу:
```Julia
using DifferentialEquations, Plots, OrdinaryDiffEq

#Начальные условия и параметры
tspan = (0,39)

p1 = [0,1.1]
p2 = [11.0,7.0]
p3 = [12.0,8.0]
x0 = [-1, -0.1]

#внешняя сила
f(t) = 4*cos(2*t)

#Функия колебаний без внешних сил
function osci_wo(dx, x, p, t)
    gamma, w = p
    dx[1] = x[2]
    dx[2] = -w .* x[1] - gamma .* x[2]
end

#Функия колебаний с внешними силами
function osci_w(dx, x, p, t)
    gamma, w = p
    dx[1] = x[2]
    dx[2] = -w .* x[1] - gamma .* x[2] .+ f(t)
end
```

Будем расписывать решение задачи для трех случаев.

Первый случай
Колебания гармонического осциллятора без затуханий и без действий внешней силы

```Julia
#Случай 1
prob1 = ODEProblem(osci_wo, x0, tspan, p1)
sol1 = solve(prob1, dtmax = 0.05)

plot(sol1) # График колебаний
plot(sol1, vars = (2, 1)) #Фазовый портрет
```
Второй случай
Колебания гармонического осциллятора c затуханием и без действий внешней силы

```Julia
#Случай 2
prob2 = ODEProblem(osci_wo, x0, tspan, p2)
sol2 = solve(prob2, dtmax = 0.05)

plot(sol2) # График колебаний
plot(sol2, vars = (2, 1)) #Фазовый портрет

```


Третий случай
Колебания гармонического осциллятора c затуханием и под действием внешней силы
```Julia
#Случай 3
prob3 = ODEProblem(osci_w, x0, tspan, p3)
sol3 = solve(prob3, dtmax = 0.05)
plot(sol3) # График колебаний
plot(sol3, vars = (2, 1)) #Фазовый портрет

```


В результате получим следующие графики (рис. @fig:001, @fig:002, @fig:003, @fig:004, @fig:005, @fig:006).

![Колебания гарм осц сл. 1](allfiles/lab4_jl_1.1.png){#fig:001 width=70%}
![Фаз портрет сл. 1](allfiles/lab4_jl_1.2.png){#fig:002 width=70%}



![Колебания гарм осц сл. 2](allfiles/lab4_jl_2.1.png){#fig:003 width=70%}
![Фаз портрет сл. 2](allfiles/lab4_jl_2.2.png){#fig:004 width=70%}




![Колебания гарм осц сл. 3](allfiles/lab4_jl_3.1.png){#fig:005 width=70%}
![Фаз портрет сл. 3](allfiles/lab4_jl_3.2.png){#fig:006 width=70%}

##Код в OpenModelica
Также построим эти графики в OpenModelica.


Для первого случая
``` OpenModelica
model lab4

Real x(start = -1.0);
Real y(start = -0.1);

parameter Real omega = 1.1;
parameter Real gamma = 0;


equation
  der(x) = y;
  der(y) = -omega*x - gamma*y;

end lab4;

```

Для второго случая
``` OpenModelica
model lab4

Real x(start = -1.0);
Real y(start = -0.1);

parameter Real omega = 11.0;
parameter Real gamma = 7.0;


equation
  der(x) = y;
  der(y) = -omega*x - gamma*y;

end lab4;
```
И для третьего случая
``` OpenModelica
model lab4

Real x(start = -1.0);
Real y(start = -0.1);

parameter Real omega = 12.0;
parameter Real gamma = 8.0;

Real p;

equation
  der(x) = y;
  der(y) = -omega*x - gamma*y + p;
  p = 4*cos(2*time);
  
end lab4;
```

В результате получим следующие графики (рис. @fig:007, @fig:008, @fig:009, @fig:0010, @fig:011, @fig:012).

![Колебания гарм осц сл. 1](allfiles/lab4_om_1.1.png){#fig:007 width=70%}
![Фаз портрет сл. 1](allfiles/lab4_om_1.2.png){#fig:008 width=70%}



![Колебания гарм осц сл. 2](allfiles/lab4_om_2.1.png){#fig:009 width=70%}
![Фаз портрет сл. 2](allfiles/lab4_om_2.2.png){#fig:0010 width=70%}




![Колебания гарм осц сл. 3](allfiles/lab4_om_3.1.png){#fig:011 width=70%}
![Фаз портрет сл. 3](allfiles/lab4_om_3.2.png){#fig:012 width=70%}

# Выводы

Мы научились строить фазовые портреты а также изучили гармонические колебания осцилятора.
