function [] = RGMcurvesplot(ndf, fi, namesf, root)

for i = 1:length(ndf)
    name = namesf{i};
    for j = 1:length(fi{i})
        newdata = ndf{i}.tb;
        dates = newdata.Data;
        basedate = datetime(dates(1), 'format', 'dd/MM/uuuu') - newdata.Dias(1);

        ft = fi{i}(j);
        pars = ft.param;
        alpha = pars(1);
        r = pars(2);
        tc = pars(3);
        K = ft.K;
        xpred = 0:300;

        y = RGM(pars,xpred,K);
        dydt = r*y.*(1-(y/K).^alpha);
        min_date = datenum('25-Feb-2020');
        max_date = datenum('31-May-2020');
        xorig = newdata.Dias;
        yorig = newdata.x_bitosAcm_;
        
        yyaxis left
        hold off
        plot(basedate + xpred, 10000*y)
        hold on
        plot(basedate + xorig, 10000*yorig, 'k.')
        hold off
        ylim auto
        ylabel({'Estimated number of cases', 'for every 10000 inhabitans'})
        xlabel('Date')        
        yyaxis right
        plot(basedate + xpred, 10000*dydt)
        ylim([0 inf])
        ylabel({'Change per day in the estimated number of cases', 'for every 10000 inhabitans'})
        xlim([min_date max_date])

        
        saveas(gcf,char(strcat('./RGM_curves/', root, '_', strrep(name,' Óbitos',''),'_K_', num2str(K), '_curve.png')))
        clf('reset')
    end
end
end