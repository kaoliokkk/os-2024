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