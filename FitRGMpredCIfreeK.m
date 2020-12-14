function [pred_ci] = FitRGMpredCIfreeK(fit, xpred, new, alpha)
    if ~exist('new','var')
        new = false; 
    end
    if ~exist('alpha','var')
        alpha = 0.05; 
    end
    if ~new
        [~,delta] = nlpredci(@(pars,x) RGM(pars(1:3),x,pars(4)),xpred,[fit.param fit.K],fit.resid,'Jacobian',full(fit.J),'Alpha',alpha);
    else
        [~,delta] = nlpredci(@(pars,x) RGM(pars(1:3),x,pars(4)),xpred,[fit.param fit.K],fit.resid,'Jacobian',full(fit.J),'PredOpt','observation','Alpha',alpha);
    end

    pred_ci = delta;
end