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
