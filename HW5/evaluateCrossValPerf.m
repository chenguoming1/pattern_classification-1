%Need 2 fold cross validation ? Will that make a difference? 
function evaluateCrossValPerf(ds)
    
    N = ds.nObservations;
    k = 4;
    keys = [];
    for iFold = 1:k
        keys = cat(1,keys,ones(N/k,1)*iFold);
    end
    keys = keys(randperm(N));
    
    %% FldOnly

    cls = prtClassFld;
    
    results = prtDataSetClass;
    results_trained = prtDataSetClass;
    
    for iFold = 1:k
        ds_train = ds.retainObservations(keys~=iFold);
        ds_test = ds.retainObservations(keys==iFold);
        cls_trained = cls.train(ds_train);
        results_trained = results_trained.catObservations(cls_trained.run(ds_train));
        results = results.catObservations(cls_trained.run(ds_test));
    end
    
    figure;
    [Pf, Pd, thresholds, FLDAUC] = prtScoreRoc(results_trained);
    FLDAUC
    %hold on;
    [Pf, Pd, thresholds, FLDAUCtest] = prtScoreRoc(results);
    FLDAUCtest
    %hold off;
    legend('train','test');
    title('FLD')

    %% PCA + Fld

    cls = prtPreProcPca('nComponents', 1) + prtClassFld;
    
    results = prtDataSetClass;
    results_trained = prtDataSetClass;
    
    for iFold = 1:k
        ds_train = ds.retainObservations(keys~=iFold);
        ds_test = ds.retainObservations(keys==iFold);
        cls_trained = cls.train(ds_train);
        results_trained = results_trained.catObservations(cls_trained.run(ds_train));
        results = results.catObservations(cls_trained.run(ds_test));
    end
    
    
    figure;
    [Pf, Pd, thresholds, PCAAUC] =prtScoreRoc(results_trained);
    PCAAUC
    hold on;
    [Pf, Pd, thresholds, PCAAUCtest] =prtScoreRoc(results);
    PCAAUCtest
    hold off;
    legend('train','test');
    title('FLD + PCA')

    %% SFS(2) + Fld

    featSel = prtFeatSelSfs;          
    cls = prtClassFld;
    results = prtDataSetClass;
    results_trained = prtDataSetClass;
    
    for iFold = 1:k
        ds_train = ds.retainObservations(keys~=iFold);
        featSel.nFeatures = 2;
        featSel = featSel.train(ds_train); 
        ds_test = ds.retainObservations(keys==iFold);
        cls_trained = cls.train(featSel.run(ds_train));
        results_trained = results_trained.catObservations(cls_trained.run(featSel.run(ds_train)));
        results = results.catObservations(cls_trained.run(featSel.run(ds_test)));
    end
     
    
    figure;
    prtScoreRoc(results_trained);
    [Pf, Pd, thresholds, SFSAUC] =prtScoreRoc(results_trained);
    SFSAUC
    hold on;
    prtScoreRoc(results);
    [Pf, Pd, thresholds, SFSAUCtest] =prtScoreRoc(results);
    SFSAUCtest
    hold off;
    legend('train','test');
    title('SFS(2) + FLD')

    %% SBS(2) + Fld

    featSel = prtFeatSelSbs;          
    cls = prtClassFld;
    results = prtDataSetClass;
    results_trained = prtDataSetClass;
    
    for iFold = 1:k
        ds_train = ds.retainObservations(keys~=iFold);
        featSel.nFeatures = 2;
        featSel = featSel.train(ds_train); 
        ds_test = ds.retainObservations(keys==iFold);
        cls_trained = cls.train(featSel.run(ds_train));
        results_trained = results.catObservations(cls_trained.run(featSel.run(ds_train)));
        results = results.catObservations(cls_trained.run(featSel.run(ds_test)));
    end
    
    
    figure;
    [Pf, Pd, thresholds, SBSAUC] =prtScoreRoc(results_trained);
    prtScoreRoc(results_trained);
    SBSAUC
    hold on;
    [Pf, Pd, thresholds, SBSAUCtest] =prtScoreRoc(results);
    SBSAUCtest
    prtScoreRoc(results);
    hold off;
    legend('train','test');
    title('SBS(2) + FLD')
end
