function P = myPKNN(Data,class)
%% Version 1: 2016-08-12
% Function to calculate the Probability of KNN class classification
% Input:
%           Data  : Class information of the nearest neighbours
%           class : number of classes available in the whole data set.
% Output: 
%           P     : Propability of each individivual class information.
%%
	[row,col] = size(Data);
    P = zeros(row,class);
    for j = 1:row
        for k = 1:class
            count = 0;
            for i = 1:col
                if Data(j,i) == k
                    count = count+1;
                end
            end
            P(j,k) = count/col;
        end
    end
end