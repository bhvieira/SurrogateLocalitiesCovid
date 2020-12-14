[fi, ndf, namesf] = FitRGMscript('Estrangeiras-COVID.xlsx', [2*(1:2), 1+2*(3:10)]);
[fn, ndn, namesn] = FitRGMscript('Modelo-dados.xlsx', 2*(1:17));

save('foreignFit.mat','fi', 'ndf', 'namesf')
save('nationalFit.mat','fn', 'ndn', 'namesn')

load('foreignFit_freeK.mat')
load('nationalFit_freeK.mat')

RGMcurvesplot(ndf, fi, namesf, 'foreign');
RGMcurvesplot(ndn, fn, namesn, 'national');

FitRGMscriptplot(fi, ndf, namesf, 'foreign_15_freeK')
FitRGMscriptplot(fn, ndn, namesn, 'national_15_freeK')