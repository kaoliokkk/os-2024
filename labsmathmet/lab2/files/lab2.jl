using Plots #подключаем необходимые библеотеки
using OrdinaryDiffEq #подключаем необходимые библеотеки
s = 20.5 #раст от лодки охраны до катера
fi = 3*pi/4
tetha1 = (0.0,2*pi)
tetha2 = (-pi,pi)


sl_1 = 2s/13 #нач услов в 1 случае
sl_2 = 2s/9 #нач услов во 2 случае
f(u,p,t) = u/sqrt(29.25) #функция движения катера береговой охраны
f2(t) = tan(fi)*t #функция движения лодки 

#решение задачи в случ 1
sl1=ODEProblem(f, sl_1, tetha1)
sol1 = solve(sl1, Tsit5(), saveat=0.01) 

#решение задачи в случ 2
sl2=ODEProblem(f, sl_2, tetha2)
sol2 = solve(sl2, Tsit5(), saveat=0.01) 


#точка пересечения для первого случая
t = 0:0.01:15
solution1(t) = (sl_1)*exp(1/sqrt(29.25)*t) 
intersection_r1 = solution1(7*pi/4) 

#построение графика для первого случая
#график движения катера
plot(sol1.t, sol1.u,
proj=:polar,
lims=(0,13)
)
#график движения лодки
plot!(fill(fi,length(t)), f2.(t))



#точка пересечения для второго случая
solution2(t) = (sl_2)*exp(5*pi*sqrt(299)/299)*exp(1/sqrt(29.25)*t) 
intersection_r2 = solution2(-pi/4)

#построение графика для второго случая
#график движения катера
plot(sol2.t, sol2.u,
proj=:polar,
lims=(0,13)
)
#график движения лодки
plot!(fill(fi,length(t)), f2.(t))



