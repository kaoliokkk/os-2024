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

prob1 = ODEProblem(f1,[x0,y0],tspan,p1)
sol1 = solve(prob1,Tsit5())
plot(sol1,title = "Модель 1",
    label = ["Army x" "Army y"],xaxis = "Time", yaxis="Soliders"
)

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