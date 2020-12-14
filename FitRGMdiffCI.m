function [yerr] = FitRGMdiffCI(f)
    par = f.param
    R = f.resid
    J = f.J

    da = dydbeta(par, floor(par(3)), f.K)
    db = dydbeta(par, ceil(par(3)), f.K)

    pCov = full(inv(J'*J)*((R'*R)./(numel(R) - numel(par))));

    for i=1:3
        for j=setdiff(1:3, i)
            pCov(i,j) = pCov(i,j)/(sqrt(pCov(i,i))*sqrt(pCov(j,j)))
        end
    end

    yerr = sqrt((db-da) * pCov * (db-da)' + 1) * sqrt(((R'*R)./(numel(R) - numel(par)))) * tinv(0.975, numel(R) - numel(par))
end