function [] = FitRGMerrorbarplot(data, pop, fit)
    basedate = datetime(data.Data(1), 'format', 'dd/MM/uuuu') - data.Dias(1);
    for i=1:min(length(fit), 10)
        fi = fit(i);
        x = fi.param(3);
        y = pop/100 * diff(RGM(fi.param,[round(x-7.5) round(x+7.5)],fi.K))/15;
        if i==1
            xerr = 1000*FitRGMparCIfreeK(fi);
            yerr = pop/100 * sqrt(sum(FitRGMpredCIfreeK(fi,[round(x-7.5) round(x+7.5)]).^2))/15;
        else
            xerr = 1000*FitRGMparCI(fi);
            yerr = pop/100 * sqrt(sum(FitRGMpredCI(fi,[round(x-7.5) round(x+7.5)]).^2))/15;
        end

        hold on
        plot(basedate + [x - xerr(3), x + xerr(3)],[y,y], 'k','HandleVisibility','off')
        plot(basedate + [x, x],[max(1, y - yerr),y + yerr], 'k','HandleVisibility','off')
        if i==1
            p = plot(basedate + x,y, 'ko','DisplayName', strcat('K = ', num2str(round(100*fi.K,1)), '% (auto)'))
        else
            p = plot(basedate + x,y, 'o','DisplayName', strcat('K = ', num2str(round(100*fi.K,1)), '%'))
        end
        set(p, 'markerfacecolor', get(p, 'color'))
    end
    legend show;
    ylabel({'15-day average number of daily fatalities', 'around the day of the peak'})
    xlabel('Date of the peak')
    legend('Location', 'bestoutside')
    set(gca, 'YScale', 'log')
    hold off
end