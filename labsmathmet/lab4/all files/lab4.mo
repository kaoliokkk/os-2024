model lab4

Real x(start = -1.0);
Real y(start = -0.1);

parameter Real omega = 1.1;
parameter Real gamma = 0;


equation
  der(x) = y;
  der(y) = -omega*x - gamma*y;

end lab4;
