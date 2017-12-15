function out = kernel_gauss(x,b)
 out = (1/(b*sqrt(2*pi))) *exp(-0.5*((x / b)).^2);

