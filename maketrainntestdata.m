function [trainData,testData,trainClass,testClass] = maketrainntestdata(FeaturePool, noofclasses, testsamplespercent, eachclasssamples,mode, testmodesamples)
%% Version 1: 2016-Sep-05
% Dividing the data in to test and train data
% Input:
%         FeaturePool       : The actual Data which has to be dividied in
%                             test and train data
%         noofclasses       : Number of Classes available.
%         testsamplespercent: Percentage of test samples and train samples
%         eachpoolsamples   : Number of samples in each pool
%         mode              : Debug Mode or Run Mode
%         debugmodesamples  : Number of samples to be used from test data in debug mode
% Output: 
%         trainData         : Training Data Samples
%         testData          : Testing Data Samples based on the mode used
%         trainClass        : Class information of the training samples
%         testClass         : Class information of the selected test sample
%%
    [row,~] = size(FeaturePool);
    Classes = ones(row,1);
    for i = 1:noofclasses
        Classes((eachclasssamples*(i-1))+1:eachclasssamples*i) = i ;
    end
    idx     = randperm(row); 
    numb    = round(row*testsamplespercent/100);
    trainData   = FeaturePool(idx(1:numb),:);
    trainClass  = Classes(idx(1:numb)); 
    if (strcmp(mode,'runmode'))
        testData   = FeaturePool(idx(numb+1:end),:);
        testClass   = Classes(idx(numb+1:end));     
    elseif(strcmp(mode,'debugmode'))
        testData   = FeaturePool(idx(numb+1:numb+testmodesamples),:);
        testClass   = Classes(idx(numb+1:numb+testmodesamples)); 
    else
        error('Terminating Run, Invalid Mode selected');
    end
end