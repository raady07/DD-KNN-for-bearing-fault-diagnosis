function indx = loadindx(set)
%% Version 1: 2016-Aug-13
% load the dataset required
% Input : 
%       set : type of data set
%       indx: indexes of the coloumns that to be selected within the pool.
%%
    if (set == 1)       indx = [2,13];
    elseif(set == 2)    indx = [2,3,9];
    elseif(set == 3)    indx = [2];              
    elseif(set == 4)    indx = [2,9,11];    
    elseif(set == 5)    indx = [2,9];    
    elseif(set == 6)    indx = [2,13];    
    elseif(set == 7)    indx = [2,12,13];    
    elseif(set == 8)    indx = [2,11,12,13];    
    elseif(set == 9)    indx = [2,12,13];
    elseif(set == 10)   indx = [2,13];
    elseif(set == 11)   indx = 1:13;
    else
        error('Terminating Run ! Invalid dataset selected');
    end
end