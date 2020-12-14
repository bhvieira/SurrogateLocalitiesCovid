function [fitObjects] = FitRGM(x,y,Ks,options,ninit)

if ~exist('ninit','var')
    ninit = 100; 
end

if ~exist('options','var')
    options = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','MaxFunctionEvaluations',1500, 'MaxIterations', 1500, 'OptimalityTolerance', 1e-16, 'FunctionTolerance', 1e-16);
end

%Anon function that fits the model
fit = @(K,parguess) lsqcurvefit(@(pars,x) RGM([pars(1) pars(2) 1000*pars(3)],x,K),parguess,x,y,[0 0 0],[1 1 Inf],options);

for i = 1:length(Ks)
    K = Ks(i);
    oldNegLik = Inf;
    j = 1;
    while j <= ninit
        parguess = rand(1,3);
        [pars,~,resid,~,~,~,J] = fit(K, parguess);
        newNegLik = sumsqr(resid);
        if newNegLik < oldNegLik
            fitObjects(i) = struct('K', K, 'param', [pars(1) pars(2) 1000*pars(3)], 'resid', resid, 'J', J);
            oldNegLik = newNegLik
        end
        if any(pars ~= parguess)
            j = j+1;
        end
    end
end
end