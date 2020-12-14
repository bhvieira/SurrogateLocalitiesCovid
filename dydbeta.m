function [del] = dydbeta(pars, x, K)
    del = [dydalpha(pars, x, K)     dydr(pars, x, K)    dydtc(pars, x, K)]
end
