function [fitObjects] = FitRGMfreeK(x,y,options,ninit)

if ~exist('ninit','var')
    ninit = 100; 
end

if ~exist('options','var')
    options = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','MaxFunctionEvaluations',1500, 'MaxIterations', 1500, 'OptimalityTolerance', 1e-16, 'FunctionTolerance', 1e-16);
end

%Anon function that fits the model
fit = @(parguess) lsqcurvefit(@(pars,x) RGM([pars(1) pars(2) 1000*pars(3)],x,pars(4)),parguess,x,y,[0 0 0 0],[1 1 Inf 1],options);

oldNegLik = Inf;
j = 1;
while j <= ninit
    parguess = rand(1,4);
    [pars,~,resid,~,~,~,J] = fit(parguess);
    newNegLik = sumsqr(resid);
    if newNegLik < oldNegLik
        fitObjects = struct('K', pars(4), 'param', [pars(1) pars(2) 1000*pars(3)], 'resid', resid, 'J', J);
        oldNegLik = newNegLik;
    end
    if any(pars ~= parguess)
        j = j+1;
    end
end
end