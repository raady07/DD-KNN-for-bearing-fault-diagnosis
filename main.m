%% Density based Distance scaling for optimizing Classification.
% Rasheduls Experiment with Case Western Dataset.
% Version 5: 2016-Sep-05

clear all; close all; clc; workspace;
% input parameters  to load data
cracktype           = '3mm';                                               % '3mm', '12mm'
rpm                 = 500;                                                 % 300, 500
test_data_set       = [1,2,3,4,5,6,7,8,9,10,11];                           % 1,2,3,4,5,6,7,8,9,10;
noofclasses         = 4;                                                   % 4,8
testsamplespercent  = 50;
eachclasssamples    = 90;
mode                = 'runmode';                                           % 'runmode','debugmode'
testmodesamples     = 10;
jump = 1;

for mn = 1: length(test_data_set)
    [trainData,testData,trainClass,testClass] = load_data(cracktype,rpm,test_data_set(mn),noofclasses,testsamplespercent, eachclasssamples,mode, testmodesamples);
    [row,~] = size(testData);
    %% 
    % Step 1 - Find the Probability of KNN


    K = [2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20];
    Obtained_Class = zeros(row,length(K));
    for j = 1:length(K)
        [n1,d1]=knnsearch(trainData,testData,'k',K(j),'distance','euclidean');
        C_dash = trainClass(n1);
        alpha = myPKNN(C_dash,noofclasses);
    % Step 2 - Find the Probability Density Factor of each class
        beta  = myPDF(trainData,trainClass,testData,K(j),noofclasses);

        alpha_dash = 1-alpha;
        Preq = alpha + alpha_dash.*beta;
        for i = 1:row
            indxed = max(Preq(i,:));
            p_c = find(indxed == Preq(i,:));
            Obtained_Class(i,j) = max(p_c);
        end 
        %% traditional KNN

        C(:,j) = knnclassify(testData,trainData,trainClass,K(j));

        Diff_our_alg(:,j) = Obtained_Class(:,j) - testClass;
        Diff_knn(:,j)     = C(:,j) - testClass;
    end
        %% Accuracies
    for j = 1: length(K)
        count = 0;
        for i = 1:row
            if (Diff_our_alg(i,j)~=0)
                count = count+1;
            end
        end
        Acc(jump,j) = ((row-count)/row)*100; % accuracy of our algorithm when using different K
        count = 0;
        for i = 1:row
            if (Diff_knn(i,j)~=0)
                count = count+1;
            end
        end
        Acc(jump+1,j) = ((row-count)/row)*100; % accuracy of traditional KNN when using different K
        
    end
    jump = jump+2;
end