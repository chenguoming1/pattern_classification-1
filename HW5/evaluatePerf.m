%Need 2 fold cross validation ? Will that make a difference? 
function evaluatePerf(dstrain,dstest)

    %% FldOnly

    cls = prtClassFld;
    cls_trained = cls.train(dstrain);
    figure;
    prtScoreRoc(cls_trained.run(dstest))
    hold on;
    prtScoreRoc(cls_trained.run(dstrain))
    hold off;
    legend('train','test')
    title('FLD Only')

    %% PCA + Fld

    cls = prtPreProcPca('nComponents', 1) + prtClassFld;
    figure;
    cls_trained = cls.train(dstrain);
    figure;
    prtScoreRoc(cls_trained.run(dstrain))
    hold on;
    prtScoreRoc(cls_trained.run(dstest))
    hold off;
    legend('train','test')
    title('FLD + PCA')

    %% SFS(2) + Fld

    extdstrainf = dstrain;
    featSel = prtFeatSelSfs;          
    featSel.nFeatures = 2;
    featSel = featSel.train(extdstrainf); 
    outDataSetf = featSel.run(extdstrainf);

    cls = prtClassFld;
    cls_trained = cls.train(outDataSetf);
    figure;
    prtScoreRoc(cls_trained.run(outDataSetf))
    hold on;
    prtScoreRoc(cls_trained.run(featSel.run(dstest)))
    hold off;
    legend('train','test')
    title('SFS(2) + FLD')

    %% SBS(2) + Fld

    extdstrainb = dstrain;
    featSel = prtFeatSelSbs;          
    featSel.nFeatures = 2;
    featSel = featSel.train(extdstrainb); 
    outDataSetb = featSel.run(extdstrainb);

    cls = prtClassFld;
    cls_trained = cls.train(outDataSetb);
    figure;
    prtScoreRoc(cls_trained.run(outDataSetb))
    hold on;
    prtScoreRoc(cls_trained.run(featSel.run(dstest)))
    hold off;
    legend('train','test')
    title('SBS(2) + FLD')
end
