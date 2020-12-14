function [pars_ci] = FitRGMparCI(fit, alpha)
if ~exist('alpha','var')
    alpha = 0.05; 
end
pars = fit.param
pars_ci = nlparci(pars,fit.resid,'jacobian',fit.J,'alpha',alpha)
pars_ci = pars - pars_ci(:,1)'
end