function [] = FitRGMplot(data, fit, days)
    if ~exist('days','var')
        days = data.Dias; 
    end
    ks = arrayfun(@(f) f.K, fit);
    for i = 1:length(fit)
        if i == 1
            name = strcat('K = ', num2str(round(100*ks(i),1)), '%, \alpha = ', num2str(round(fit(i).param(1), 2)), ', r = ', num2str(round(fit(i).param(2), 2)), ' (auto)');
            plot(datetime(data.Data(1), 'format', 'dd/MM/uuuu') - data.Dias(1) + days, 10000*RGM(fit(i).param, days, ks(i)), 'k', 'DisplayName', name)
        else
            name = strcat('K = ', num2str(round(100*ks(i),1)), '%, \alpha = ', num2str(round(fit(i).param(1), 2)), ', r = ', num2str(round(fit(i).param(2), 2)));
            plot(datetime(data.Data(1), 'format', 'dd/MM/uuuu') - data.Dias(1) + days, 10000*RGM(fit(i).param, days, ks(i)), 'DisplayName', name)
        end
        hold on
    end
    plot(datetime(data.Data, 'format', 'dd/MM/uuuu'), 10000*data.x_bitosAcm_, 'DisplayName', 'Data', 'Color', 'black', 'LineWidth', 3)
    xlabel('Date')
    ylabel({'Estimated number of cases', 'for every 10000 inhabitans'})
    hold off
    legend show
    legend('Location', 'best')
end