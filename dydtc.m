function [del] = dydtc(pars, x, K)
    y = RGM(pars,x,K)
    alpha = pars(1)
    r = pars(2)
    tc = pars(3)

    del = ((y^(alpha+1))/(K^alpha))*alpha*r*exp(-alpha*r*(x-tc))
end
