function evaluatePca(data, nComponents)
if nargin<2
    nComponents = 1;
end

warning('off','MATLAB:nearlySingularMatrix')

% run FLD
fld = prtClassFld;
prtScoreRoc(fld.kfolds(data,data.nObservations))

hold on

% run FLD+PCA
pca_fld = prtPreProcPca('nComponents',nComponents) + prtClassFld;
prtScoreRoc(pca_fld.kfolds(data,data.nObservations))

hold off
warning('on','MATLAB:nearlySingularMatrix')

% add legend
legend('FLD','FLD+PCA',...
    'Location','southeast')