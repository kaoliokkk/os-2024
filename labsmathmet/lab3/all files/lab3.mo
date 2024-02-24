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
