function [del] = dydalpha(pars, x, K)
    y = RGM(pars,x,K)
    alpha = pars(1)
    r = pars(2)
    tc = pars(3)

    del = y * (-log(y/K)/alpha - ((y/K)^alpha)*((1-alpha*r*(x-tc))/alpha)*exp(-alpha*r*(x-tc)))
end
