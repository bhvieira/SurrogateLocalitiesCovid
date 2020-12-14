function [] = FitRGMscriptplot(f, newdata, sheetNames, root)
    for a=1:length(f)
        close
        FitRGMerrorbarplot(newdata{a}.tb, newdata{a}.pop, f{a})
        title(strrep(sheetNames(a),' �bitos',''))
        saveas(gcf,char(strcat(root, '/', root, '_', strrep(sheetNames(a),' �bitos',''), '_peak.png')))
    end

    for i=1:length(f)
        FitRGMplot(newdata{i}.tb, f{i}, 20:200)
        title(strcat(strrep(sheetNames(i),' �bitos',''), ' - estimate of cases'))
        saveas(gcf,char(strcat(root, '/', root, '_', strrep(sheetNames(i),' �bitos',''), '_curve.png')))
    end
end