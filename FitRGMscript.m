function [f, newdata, sheetNames] = FitRGMscript(filename, sheets, minFatalities)

    if ~exist('filename','var')
        error('Provide a filename for the .xls')
    end

    if ~exist('filename','var')
        error('Provide a selection of sheets')
    end

    if ~exist('minFatalities','var')
        %determine a minimum number of fatalities
        minFatalities = 15; 
    end

    [~, sheetNames] = xlsfinfo(filename); %to retrieve sheet names
    data = arrayfun(@(s) loader(filename, s), sheets, 'UniformOutput', false);

    sheetNames = sheetNames(sheets);

    %A numeric vector with different values for the parameter K
    Ks = [5 10 15 20 25 30 35 40 50 60 80 94]/100;

    %create new tables starting from minFatalities
    newdata = cellfun(@(dt) struct('tb', dt.tb(dt.tb.x_bitosAcm_ >= minFatalities ,:), 'pop', dt.pop), data, 'UniformOutput', false);

    sheetNames = sheetNames(~cellfun(@(n) isempty(n.tb), newdata));
    newdata = newdata(~cellfun(@(n) isempty(n.tb), newdata));

    for n=1:length(newdata)
        newdata{n}.tb.x_bitosAcm_(:) = 100* (newdata{n}.tb.x_bitosAcm_/newdata{n}.pop);
    end

    f = cellfun(@(dat) FitRGM(dat.tb.Dias,dat.tb.x_bitosAcm_,Ks), newdata, 'UniformOutput', false);
    fK = cellfun(@(dat) FitRGMfreeK(dat.tb.Dias,dat.tb.x_bitosAcm_), newdata, 'UniformOutput', false);
    
    for i = 1:length(f)
        f{i} = [fK{i}, f{i}];
    end
end