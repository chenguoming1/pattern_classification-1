
function CleanEvaluateCrossValPerf(ds)

    %% FldOnly

    cls = prtClassFld;
    results = cls.kfolds(ds,2);
    
    figure;
   [Pf, Pd, Threshold, AUC] = prtScoreRoc(results);
    prtScoreRoc(results);
    'FLD'
    AUC
    title('FLD')

    %% PCA + Fld

    cls = prtPreProcPca('nComponents', 1) + prtClassFld;
    results = cls.kfolds(ds,2);
    
    figure;
    [Pf, Pd, Threshold, AUC] = prtScoreRoc(results);
    prtScoreRoc(results);
    'FLD + PCA'
    AUC
    title('FLD + PCA')

    %% SFS(2) + Fld

    featSel = prtFeatSelSfs;
    featSel.nFeatures = 2;
    featSel = featSel.train(ds); 
    outds = featSel.run(ds);
    cls = prtClassFld;
    results = cls.kfolds(outds,2);
    
    figure;
    [Pf, Pd, Threshold, AUC] = prtScoreRoc(results);
    prtScoreRoc(results);
    'SFS + FLD'
    AUC
 
    title('SFS(2)+FLD')

    %% SBS(2) + Fld

    featSel = prtFeatSelSbs;
    featSel.nFeatures = 2;
    featSel = featSel.train(ds); 
    outds = featSel.run(ds);
    cls = prtClassFld;
    results = cls.kfolds(outds,2);
    
    figure;
    [Pf, Pd, Threshold, AUC] = prtScoreRoc(results);
    prtScoreRoc(results);
   'SBS + FLD' 
    AUC
    prtScoreRoc(results);
    title('SBS(2)+FLD')
end
