function [y] = RGM(pars,x,K)
    %Richards growth forward model
    y = K./((1+ pars(1) * exp(-pars(1)*pars(2).* (x - pars(3)))).^(1/pars(1)));
end