function [trainData,testData,trainClass,testClass] = load_data(cracktype,rpm,testset,noofclasses,testsamplespercent, eachclasssamples,mode, testmodesamples)
%% Version 2: 2016-Sep-05
% Function to load the data based on parameters type of crack, rpm, and
% features required.
% Input
%       type        : type of crack
%       rpm         : selected rpm
%       set         : dataset (features required) selected
%       noofclasses : number of classes to be loaded.
% Output
%       FeaturePool: The complete feature pool of all the classes.
%%
    indices = loadindx(testset);
    
    if strcmp(cracktype,'3mm')
        if (rpm ==300)
            load('FeaturePool_3mm_300_with_normal.mat');
        elseif (rpm ==500)
            load('FeaturePool_3mm_500_with_normal.mat');
        else
            error('Terminating Run, Invalid RPM selected');
        end
    elseif strcmp(cracktype,'12mm')
        load('FeaturePool_12mm_300_with_normal.mat');
    else
        fprintf('Crack Type - %s\n',type);
        error('Undentified in the dataset. Terminating Run.');
    end
    
    if (noofclasses == 4)
        eval(sprintf('FeaturePool = [ FeaturePool_%s_%d_inner(:,indices); FeaturePool_%s_%d_outer(:,indices); FeaturePool_%s_%d_roller(:,indices); FeaturePool_normal_%d_normal(:,indices);];',cracktype,rpm,cracktype,rpm,cracktype,rpm,rpm));
    elseif (noofclasses == 8)
        eval(sprintf('FeaturePool = [ FeaturePool_%s_%d_inner(:,indices); FeaturePool_%s_%d_outer(:,indices); FeaturePool_%s_%d_roller(:,indices); FeaturePool_%s_%d_inner_roller(:,indices); FeaturePool_%s_%d_outer_inner(:,indices); FeaturePool_%s_%d_outer_roller(:,indices); FeaturePool_%s_%d_inner_outer_roller(:,indices); FeaturePool_normal_%d_normal(:,indices);];',cracktype,rpm,cracktype,rpm,cracktype,rpm,cracktype,rpm,cracktype,rpm,cracktype,rpm,cracktype,rpm,rpm));
    else
        fprint('Number of Classes selected - %d',noofclasses);
        error('Invalid class selection. Please either 4 or 8. Terminating Run!');
    end
    % Normalizing the data for ranging between 0 to 1.
    FeaturePool = normalizedata(FeaturePool);
    
   [trainData,testData,trainClass,testClass] = maketrainntestdata(FeaturePool, noofclasses, testsamplespercent, eachclasssamples,mode, testmodesamples);

end