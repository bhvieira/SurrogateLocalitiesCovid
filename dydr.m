function [del] = dydr(pars, x, K)
    y = RGM(pars,x,K)
    alpha = pars(1)
    r = pars(2)
    tc = pars(3)

    del = ((y^(alpha+1))/(K^alpha))*alpha*(x-tc)*exp(-alpha*r*(x-tc))
end
