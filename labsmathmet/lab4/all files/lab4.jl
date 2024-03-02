using DifferentialEquations, Plots, OrdinaryDiffEq
#Задаем нач условия
tspan = (0,39)

p1=[0,1.1]
p2=[11.0,7.0]
p3=[12.0,8.0]

x0=[-1,-0.1]

#Внешняя сила
f(t)=4*cos(2*t)

#функция без внешних сил
function osc_wo(dx,x,p,t)
    gamma,w = p
    dx[1] = x[2]
    dx[2] = -w .* x[1] - gamma .* x[2]
end

#функция с внешними силами
function osc_w(dx,x,p,t)
    gamma,w = p
    dx[1] = x[2]
    dx[2] = -w .* x[1] - gamma .* x[2] + f(t)
end

#случай 1
prob1= ODEProblem(osc_wo,x0,tspan,p1)
sol1= solve(prob1,dtmax= 0.05)

#график и портрет 1 случ
#граф колеб
plot(sol1)
#фаз портрет
plot(sol1,vars = (2,1))

#случай 2
prob2= ODEProblem(osc_wo,x0,tspan,p2)
sol2= solve(prob2,dtmax= 0.05)


#график и портрет 2 случ
#граф колеб
plot(sol2)
#фаз портрет
plot(sol2,vars = (2,1))


#случай 3
prob3= ODEProblem(osc_w,x0,tspan,p3)
sol3= solve(prob3,dtmax= 0.05)


#график и портрет 3 случ
#граф колеб
plot(sol3)
#фаз портрет
plot(sol3,vars = (2,1))