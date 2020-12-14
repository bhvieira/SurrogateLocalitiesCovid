function [data] = loader(filename, sheet)
    tb = readtable(filename, 'Range', 'A3:C200', 'Sheet', sheet);
    EmptyCell = cellfun(@isempty,tb.Data); %determine empty cells in the Data column
    tb = tb(~EmptyCell,:); %exclude said cells
    pop = readtable(filename, 'Range', 'I1', 'Sheet', sheet, 'ReadVariableNames', false);
    pop = table2array(pop);
    data = struct('tb', tb, 'pop', pop);
end